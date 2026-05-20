#!/usr/bin/env python3
"""Generate an AIA demo page pair from a live Canada.ca page.

Fetches the EN and FR live pages, extracts <main> content + metadata, and writes
two demo files using prairies-economic-development.html / developpement-economique-prairies.html
as the templates. Also inserts an alphabetical entry into en/aia/index.html and fr/aia/index.html.

Usage:
    python scrape_demo.py <en-url> <fr-url>
    python scrape_demo.py <en-url> <fr-url> --en-out ircc/contact-ircc.html --fr-out ircc/contactez-ircc.html
    python scrape_demo.py <en-url> <fr-url> --skip-index

The output files are written to:
    <repo>/en/aia/<en-out>     (default: <slug-from-en-url>.html)
    <repo>/fr/aia/<fr-out>     (default: <slug-from-fr-url>.html)

After running, review the diffs before committing. The script handles the mechanical
parts; you may still want to tweak the breadcrumb, the contextual footer (gc-contextual)
if the live page has department-specific footer content, or the index entry text.
"""

import argparse
import datetime
import re
import shutil
import subprocess
import sys
import unicodedata
from html import unescape
from pathlib import Path
from urllib.parse import urlparse
from urllib.request import Request, urlopen

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
EN_DIR = REPO_ROOT / "en" / "aia"
FR_DIR = REPO_ROOT / "fr" / "aia"
EN_TEMPLATE = EN_DIR / "prairies-economic-development.html"
FR_TEMPLATE = FR_DIR / "developpement-economique-prairies.html"
EN_INDEX = EN_DIR / "index.html"
FR_INDEX = FR_DIR / "index.html"

UA = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36"


def fetch(url):
    """Fetch URL as text. Prefers curl (handles HTTP/2 + Akamai cleanly) and
    falls back to urllib if curl is unavailable."""
    curl = shutil.which("curl")
    if curl:
        result = subprocess.run(
            [curl, "-sSL", "--http1.1", "--max-time", "30", "-A", UA,
             "-H", "Accept-Language: en,fr;q=0.8", url],
            capture_output=True,
            check=False,
        )
        if result.returncode != 0:
            stderr = result.stderr.decode("utf-8", errors="replace").strip()
            raise SystemExit(f"curl failed for {url}: {stderr}")
        return result.stdout.decode("utf-8", errors="replace")
    # urllib fallback
    req = Request(url, headers={"User-Agent": UA, "Accept-Language": "en,fr;q=0.8"})
    with urlopen(req, timeout=30) as resp:
        data = resp.read()
    encoding = resp.headers.get_content_charset() or "utf-8"
    return data.decode(encoding, errors="replace")


def extract_meta(html, name):
    pats = [
        rf'<meta\s+name="{re.escape(name)}"[^>]*?\scontent="([^"]*)"',
        rf'<meta\s+content="([^"]*)"\s+name="{re.escape(name)}"',
    ]
    for p in pats:
        m = re.search(p, html, re.IGNORECASE)
        if m:
            return unescape(m.group(1))
    return None


def extract_title(html):
    m = re.search(r"<title>([\s\S]*?)</title>", html, re.IGNORECASE)
    return unescape(m.group(1).strip()) if m else None


def extract_canonical(html):
    m = re.search(r'<link\s+rel="canonical"\s+href="([^"]+)"', html, re.IGNORECASE)
    return m.group(1) if m else None


def extract_alternate(html, lang):
    m = re.search(
        rf'<link\s+rel="alternate"\s+hreflang="{lang}"\s+href="([^"]+)"',
        html, re.IGNORECASE,
    )
    return m.group(1) if m else None


def extract_main(html, lang):
    """Return (main_attrs, inner_html_with_h1_patched_and_pagedetails_stripped)."""
    m = re.search(r"<main(\s[^>]*)?>([\s\S]*?)</main>", html, re.IGNORECASE)
    if not m:
        raise SystemExit("Could not find <main>...</main> in live page source")
    attrs = m.group(1) or ""
    inner = m.group(2)

    # Strip the live page's pagedetails section — the demo template provides its own.
    # Matches `class="pagedetails"` as well as `class="pagedetails container"` etc.
    inner = re.sub(
        r'\s*<section class="pagedetails(?:\s[^"]*)?"[^>]*>[\s\S]*?</section>\s*',
        "\n",
        inner,
    )
    # Idempotency: if input is already a demo page, drop its AI Answers rescue block
    # (and the wrapper container div if present) so we don't end up with duplicates.
    inner = re.sub(
        r"\s*<!--\s*AI ANSWERS RESCUE\s*-->\s*",
        "\n",
        inner,
    )
    inner = re.sub(
        r'\s*<section class="aia-rescue"[^>]*>[\s\S]*?</section>\s*',
        "\n",
        inner,
    )

    # Append (demo) / (démo) to the H1 if not already present
    suffix = " (demo)" if lang == "en" else " (démo)"

    def patch_h1(match):
        open_tag, content, close_tag = match.group(1), match.group(2), match.group(3)
        # Skip if already suffixed (idempotent)
        if re.search(re.escape(suffix.strip()) + r"\s*$", content):
            return match.group(0)
        return f"{open_tag}{content.rstrip()}{suffix}{close_tag}"

    new_inner, n = re.subn(
        r'(<h1[^>]*\bid="wb-cont"[^>]*>)([\s\S]*?)(</h1>)',
        patch_h1,
        inner,
        count=1,
    )
    if n == 0:
        print("Warning: no <h1 id=\"wb-cont\"> found — h1 not patched", file=sys.stderr)
    return attrs, new_inner


def build_main_block(main_attrs, main_inner, lang, today):
    if lang == "en":
        rescue = (
            '        <!-- AI ANSWERS RESCUE -->\n'
            '\n'
            '        <section class="aia-rescue">\n'
            '            <h3 class="wb-inv">AI answers</h3>\n'
            '            <div class="d-flex align-items-center">\n'
            '                <img src="https://canada.ca/content/dam/canada/ai-stars-blue.png" alt="">\n'
            '                <p><strong>Need help?</strong> <a href="https://ai-answers.alpha.canada.ca" referrerpolicy="unsafe-url">Ask AI Answers for help</a></p>\n'
            '            </div>\n'
            '        </section>'
        )
        pagedetails = (
            '            <section class="pagedetails">\n'
            '    <h2 class="wb-inv">Page details</h2>\n'
            '    <div class="row">\n'
            '        <div class="col-sm-8 col-md-9 col-lg-9">\n'
            '        </div>\n'
            '\t</div>\n'
            '<gcds-date-modified>\n'
            f'\t{today}\n'
            '</gcds-date-modified>\n'
            '</section>'
        )
    else:
        rescue = (
            '        <!-- AI ANSWERS RESCUE -->\n'
            '\n'
            '        <section class="aia-rescue">\n'
            '            <h3 class="wb-inv">Réponses IA</h3>\n'
            '            <div class="d-flex align-items-center">\n'
            '                <img src="https://canada.ca/content/dam/canada/ai-stars-blue.png" alt="">\n'
            "                <p><strong>Besoin d'aide ?</strong> <a href=\"https://ai-answers.alpha.canada.ca\" referrerpolicy=\"unsafe-url\">Demander de l'aide à Réponses IA</a></p>\n"
            '            </div>\n'
            '        </section>'
        )
        pagedetails = (
            '            <section class="pagedetails">\n'
            '    <h2 class="wb-inv">Détails de la page</h2>\n'
            '    <div class="row">\n'
            '        <div class="col-sm-8 col-md-9 col-lg-9">\n'
            '        </div>\n'
            '\t</div>\n'
            '<gcds-date-modified>\n'
            f'\t{today}\n'
            '</gcds-date-modified>\n'
            '</section>'
        )

    return (
        f"<main{main_attrs}>\n"
        f"{main_inner.strip()}\n"
        f"\n"
        f"{rescue}\n"
        f"\n"
        f"{pagedetails}\n"
        f"        </main>"
    )


def replace_meta(text, name, value):
    """Replace the content="" of a <meta name="..."> tag. Returns updated text."""
    if value is None:
        return text
    val_esc = value.replace("\\", r"\\")
    # Two attribute orderings to handle
    new_text, n = re.subn(
        rf'(<meta\s+name="{re.escape(name)}"[^>]*?\scontent=")[^"]*(")',
        lambda m: f"{m.group(1)}{val_esc}{m.group(2)}",
        text,
        count=1,
    )
    if n == 0:
        new_text, n = re.subn(
            rf'(<meta\s+content=")[^"]*("\s+name="{re.escape(name)}")',
            lambda m: f"{m.group(1)}{val_esc}{m.group(2)}",
            text,
            count=1,
        )
    return new_text


def render_demo(template_path, out_path, lang, params):
    text = template_path.read_text(encoding="utf-8")

    # <title>
    text = re.sub(
        r"<title>[\s\S]*?</title>",
        f"<title>{params['title_tag']}</title>",
        text,
        count=1,
    )

    # canonical + alternates
    canonical_url = params["live_en_url"] if lang == "en" else params["live_fr_url"]
    text = re.sub(
        r'(<link\s+rel="canonical"\s+href=")[^"]*(")',
        lambda m: f"{m.group(1)}{canonical_url}{m.group(2)}",
        text, count=1,
    )
    text = re.sub(
        r'(<link\s+rel="alternate"\s+hreflang="en"\s+href=")[^"]*(")',
        lambda m: f"{m.group(1)}{params['live_en_url']}{m.group(2)}",
        text, count=1,
    )
    text = re.sub(
        r'(<link\s+rel="alternate"\s+hreflang="fr"\s+href=")[^"]*(")',
        lambda m: f"{m.group(1)}{params['live_fr_url']}{m.group(2)}",
        text, count=1,
    )

    # meta tags (description, author, dcterms.*)
    for name, value in params["meta"].items():
        text = replace_meta(text, name, value)

    # Always set dcterms.modified to today
    text = replace_meta(text, "dcterms.modified", params["today"])

    # Language toggle: point to the sibling demo on test.canada.ca
    if lang == "en":
        text = re.sub(
            r'(<a\s+lang="fr"\s+href=")https://test\.canada\.ca/experimental/fr/aia/[^"]*(")',
            lambda m: f"{m.group(1)}https://test.canada.ca/experimental/fr/aia/{params['fr_out']}{m.group(2)}",
            text, count=1,
        )
    else:
        text = re.sub(
            r'(<a\s+lang="en"\s+href=")https://test\.canada\.ca/experimental/en/aia/[^"]*(")',
            lambda m: f"{m.group(1)}https://test.canada.ca/experimental/en/aia/{params['en_out']}{m.group(2)}",
            text, count=1,
        )

    # Breadcrumb: replace "Live version" / "Version en ligne" leaf href
    if lang == "en":
        text = re.sub(
            r"(<li><a href=')https://www\.canada\.ca/en/[^']*('>Live version</a></li>)",
            lambda m: f"{m.group(1)}{params['live_en_url']}{m.group(2)}",
            text, count=1,
        )
    else:
        text = re.sub(
            r"(<li><a href=')https://www\.canada\.ca/fr/[^']*('>Version en ligne</a></li>)",
            lambda m: f"{m.group(1)}{params['live_fr_url']}{m.group(2)}",
            text, count=1,
        )

    # Swap <main> block
    new_main = build_main_block(
        params["main_attrs"], params["main_inner"], lang, params["today"]
    )
    # Escape backslashes that re.sub would otherwise interpret
    text = re.sub(
        r"<main(\s[^>]*)?>[\s\S]*?</main>",
        lambda m: new_main,
        text,
        count=1,
    )

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(text, encoding="utf-8")


def _index_sort_key(s):
    """Normalize an h3 string for alphabetical comparison (strip HTML entities + accents)."""
    decoded = unescape(s).strip()
    nfd = unicodedata.normalize("NFD", decoded)
    ascii_only = "".join(c for c in nfd if not unicodedata.combining(c))
    return ascii_only.lower()


def insert_index_entry(index_path, lang, dept_name, demo_url, demo_text, live_url, live_text):
    text = index_path.read_text(encoding="utf-8")

    if lang == "en":
        new_section = (
            '<section class="col-md-6 mrgn-bttm-lg">\n'
            f'<h3>{dept_name}</h3>\n'
            '<ul>\n'
            f'<li>Demo page: <a href="{demo_url}">{demo_text}</a></li>\n'
            f'<li>Live page: <a href="{live_url}">{live_text}</a></li>\n'
            '</ul>\n'
            '</section>'
        )
    else:
        new_section = (
            '<section class="col-md-6 mrgn-bttm-lg">\n'
            f'<h3>{dept_name}</h3>\n'
            '<ul>\n'
            f'<li>Page de d&eacute;mo&nbsp;: <a href="{demo_url}">{demo_text}</a></li>\n'
            f'<li>Page en ligne&nbsp;: <a href="{live_url}">{live_text}</a></li>\n'
            '</ul>\n'
            '</section>'
        )

    sections = list(re.finditer(
        r'<section class="col-md-6 mrgn-bttm-lg">\s*<h3>([\s\S]*?)</h3>[\s\S]*?</section>',
        text,
    ))
    if not sections:
        print(f"Warning: no existing index entries found in {index_path}, skipping.", file=sys.stderr)
        return

    new_key = _index_sort_key(dept_name)
    if any(_index_sort_key(s.group(1)) == new_key for s in sections):
        print(f"Note: an index entry for \"{dept_name}\" already exists in {index_path.name} — skipping.", file=sys.stderr)
        return

    insert_at = None
    for m in sections:
        if _index_sort_key(m.group(1)) > new_key:
            insert_at = m.start()
            break

    if insert_at is None:
        # Append after the last section
        last = sections[-1]
        new_text = text[: last.end()] + "\n\n" + new_section + text[last.end():]
    else:
        new_text = text[:insert_at] + new_section + "\n\n" + text[insert_at:]

    index_path.write_text(new_text, encoding="utf-8")


def first_nonempty(*vals):
    for v in vals:
        if v:
            return v.strip()
    return None


def derive_h1_text(main_inner):
    m = re.search(r'<h1[^>]*\bid="wb-cont"[^>]*>([\s\S]*?)</h1>', main_inner)
    if not m:
        return None
    raw = re.sub(r"<[^>]+>", "", m.group(1))
    raw = unescape(raw).strip()
    # Strip our own (demo)/(démo) suffix if it slipped in
    raw = re.sub(r"\s*\((demo|démo)\)\s*$", "", raw, flags=re.IGNORECASE)
    return raw


def url_to_slug(url):
    path = urlparse(url).path.rstrip("/")
    last = path.rsplit("/", 1)[-1]
    return last.removesuffix(".html") if last.endswith(".html") else last


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("en_url", help="Live English Canada.ca URL")
    parser.add_argument("fr_url", help="Live French Canada.ca URL")
    parser.add_argument("--en-out", help="Output path relative to en/aia/ (default: <slug>.html)")
    parser.add_argument("--fr-out", help="Output path relative to fr/aia/ (default: <slug>.html)")
    parser.add_argument("--en-dept-name", help="Department name (H3) for en/aia/index.html entry. Defaults to dcterms.creator or page title.")
    parser.add_argument("--fr-dept-name", help="Department name (H3) for fr/aia/index.html entry.")
    parser.add_argument("--skip-index", action="store_true", help="Don't update the index.html files")
    parser.add_argument("--no-fetch", action="store_true", help="(debug) Use cached EN_HTML/FR_HTML files in CWD instead of fetching")
    args = parser.parse_args()

    today = datetime.date.today().isoformat()

    print(f"Fetching {args.en_url}", file=sys.stderr)
    en_html = Path("EN_HTML").read_text(encoding="utf-8") if args.no_fetch else fetch(args.en_url)
    print(f"Fetching {args.fr_url}", file=sys.stderr)
    fr_html = Path("FR_HTML").read_text(encoding="utf-8") if args.no_fetch else fetch(args.fr_url)

    # Output paths
    en_out_rel = args.en_out or f"{url_to_slug(args.en_url)}.html"
    fr_out_rel = args.fr_out or f"{url_to_slug(args.fr_url)}.html"
    en_out_path = EN_DIR / en_out_rel
    fr_out_path = FR_DIR / fr_out_rel

    # Extract main + metadata for each
    en_main_attrs, en_main_inner = extract_main(en_html, "en")
    fr_main_attrs, fr_main_inner = extract_main(fr_html, "fr")

    en_title_tag = first_nonempty(extract_title(en_html)) or "Canada.ca"
    fr_title_tag = first_nonempty(extract_title(fr_html)) or "Canada.ca"

    en_meta = {
        "description": extract_meta(en_html, "description"),
        "author": extract_meta(en_html, "author"),
        "dcterms.title": extract_meta(en_html, "dcterms.title"),
        "dcterms.description": extract_meta(en_html, "dcterms.description"),
        "dcterms.creator": extract_meta(en_html, "dcterms.creator"),
        "dcterms.subject": extract_meta(en_html, "dcterms.subject"),
        "dcterms.issued": extract_meta(en_html, "dcterms.issued"),
    }
    fr_meta = {
        "description": extract_meta(fr_html, "description"),
        "author": extract_meta(fr_html, "author"),
        "dcterms.title": extract_meta(fr_html, "dcterms.title"),
        "dcterms.description": extract_meta(fr_html, "dcterms.description"),
        "dcterms.creator": extract_meta(fr_html, "dcterms.creator"),
        "dcterms.subject": extract_meta(fr_html, "dcterms.subject"),
        "dcterms.issued": extract_meta(fr_html, "dcterms.issued"),
    }

    common = {
        "live_en_url": args.en_url,
        "live_fr_url": args.fr_url,
        "en_out": en_out_rel,
        "fr_out": fr_out_rel,
        "today": today,
    }

    print(f"Writing {en_out_path}", file=sys.stderr)
    render_demo(
        EN_TEMPLATE, en_out_path, "en",
        {**common, "title_tag": en_title_tag, "meta": en_meta,
         "main_attrs": en_main_attrs, "main_inner": en_main_inner},
    )
    print(f"Writing {fr_out_path}", file=sys.stderr)
    render_demo(
        FR_TEMPLATE, fr_out_path, "fr",
        {**common, "title_tag": fr_title_tag, "meta": fr_meta,
         "main_attrs": fr_main_attrs, "main_inner": fr_main_inner},
    )

    if not args.skip_index:
        en_dept = args.en_dept_name or first_nonempty(
            en_meta.get("dcterms.creator"),
            en_meta.get("author"),
            re.sub(r"\s*-\s*Canada\.ca\s*$", "", en_title_tag),
        )
        fr_dept = args.fr_dept_name or first_nonempty(
            fr_meta.get("dcterms.creator"),
            fr_meta.get("author"),
            re.sub(r"\s*-\s*Canada\.ca\s*$", "", fr_title_tag),
        )
        en_h1 = derive_h1_text(en_main_inner) or en_dept
        fr_h1 = derive_h1_text(fr_main_inner) or fr_dept

        print(f"Updating {EN_INDEX}", file=sys.stderr)
        insert_index_entry(
            EN_INDEX, "en", en_dept,
            f"https://test.canada.ca/experimental/en/aia/{en_out_rel}",
            f"{en_h1} (test)",
            args.en_url, en_h1,
        )
        print(f"Updating {FR_INDEX}", file=sys.stderr)
        insert_index_entry(
            FR_INDEX, "fr", fr_dept,
            f"https://test.canada.ca/experimental/fr/aia/{fr_out_rel}",
            f"{fr_h1} (test)",
            args.fr_url, fr_h1,
        )

    print("\nDone. Review the diffs before committing — pay attention to:", file=sys.stderr)
    print("  - The gc-contextual footer (step 8 in how-to): the template inherits PrairiesCan's;", file=sys.stderr)
    print("    if the live page has a department-specific contextual footer, copy that across manually.", file=sys.stderr)
    print("  - Index entry text (department name + link text) — easy to tweak if defaults aren't right.", file=sys.stderr)
    print("  - dcterms.subject is institution-specific; the script copies the live page's value.", file=sys.stderr)


if __name__ == "__main__":
    main()
