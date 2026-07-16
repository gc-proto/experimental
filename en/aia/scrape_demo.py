#!/usr/bin/env python3
"""Generate an AIA demo page pair from a live Canada.ca page.

Fetches the EN and FR live pages, extracts <main> content + metadata, and writes
two demo files using military-career-transition.html / transition-carriere-militaire.html
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
EN_TEMPLATE = EN_DIR / "military-career-transition.html"
FR_TEMPLATE = FR_DIR / "transition-carriere-militaire.html"
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
    """Return inner_html_with_h1_patched_and_pagedetails_stripped.

    Only the *contents* of the live <main> are kept. The source page's <main>
    attributes are deliberately discarded: department sites on their own domains
    (tc.canada.ca, fednor.canada.ca) carry theme-specific classes there that break
    layout once the content is dropped into the canada.ca WET template.
    """
    m = re.search(r"<main(\s[^>]*)?>([\s\S]*?)</main>", html, re.IGNORECASE)
    if not m:
        raise SystemExit("Could not find <main>...</main> in live page source")
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
    return new_inner


def rewrite_relative_urls(inner, base):
    """Rewrite root-relative href/src and CSS url() paths to absolute URLs on `base`.

    Demo pages are served from test.canada.ca/experimental/, so a source page's
    root-relative paths would otherwise resolve against the wrong host.
    """
    inner = re.sub(
        r'((?:href|src)=")(/[^"]*)(")',
        lambda m: f"{m.group(1)}{base}{m.group(2)}{m.group(3)}",
        inner,
    )
    inner = re.sub(
        r"(url\(\s*['\"]?)(/[^'\")]*)",
        lambda m: f"{m.group(1)}{base}{m.group(2)}",
        inner,
    )
    # Drupal bookkeeping; only the href matters for the demo.
    inner = re.sub(r'\s+data-entity-(?:substitution|type|uuid)="[^"]*"', "", inner)
    return inner


def build_main_block(template_text, main_inner, today):
    """Assemble the demo's <main> from the template's own scaffolding.

    The opening <main> tag, the AI Answers rescue block and the pagedetails section
    are lifted from the template rather than hardcoded here, so the template stays
    the single source of truth for the AI Answers pattern (and for the French
    wording / reponses-ia URLs, which differ from English).
    """
    tmain = re.search(r"(<main(?:\s[^>]*)?>)([\s\S]*?)(</main>)", template_text, re.IGNORECASE)
    if not tmain:
        raise SystemExit("Could not find <main>...</main> in the template")
    main_open, tpl_inner = tmain.group(1), tmain.group(2)

    rescue = re.search(
        r"<!--\s*AI ANSWERS RESCUE\s*-->[\s\S]*?</section>\s*</div>", tpl_inner
    )
    if not rescue:
        raise SystemExit("Could not find the AI ANSWERS RESCUE block in the template")

    pagedetails = re.search(
        r'<section class="pagedetails(?:\s[^"]*)?"[^>]*>[\s\S]*?</section>', tpl_inner
    )
    if not pagedetails:
        raise SystemExit("Could not find the pagedetails section in the template")
    pagedetails = re.sub(
        r"(<gcds-date-modified>\s*)[^<]*(\s*</gcds-date-modified>)",
        lambda m: f"{m.group(1)}{today}{m.group(2)}",
        pagedetails.group(0),
        count=1,
    )

    return (
        f"{main_open}\n"
        f"{main_inner.strip()}\n"
        f"\n"
        f"        {rescue.group(0)}\n"
        f"\n"
        f"            {pagedetails}\n"
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

    # Breadcrumb: rebuild the whole list, not just the leaf href — the template's
    # own intermediate levels (e.g. "National Defence") don't belong on other pages.
    # Per the how-to, Canada.ca + a "Live version" leaf is the baseline; add a
    # department-landing level by hand if the page warrants one.
    if lang == "en":
        crumbs = (
            "<li><a href='https://www.canada.ca/en.html'>Canada.ca</a></li>\n"
            f"<li><a href='{params['live_en_url']}'>Live version</a></li>"
        )
    else:
        crumbs = (
            "<li><a href='https://www.canada.ca/fr.html'>Canada.ca</a></li>\n"
            f"<li><a href='{params['live_fr_url']}'>Version en ligne</a></li>"
        )
    text, n = re.subn(
        r'(<ol class="breadcrumb">)[\s\S]*?(</ol>)',
        lambda m: f"{m.group(1)}\n{crumbs}\n{m.group(2)}",
        text, count=1,
    )
    if n == 0:
        print("Warning: breadcrumb not found — check it by hand", file=sys.stderr)

    # Swap <main> block
    new_main = build_main_block(text, params["main_inner"], params["today"])
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


def url_base(url):
    """Scheme + host of a URL, e.g. https://tc.canada.ca"""
    p = urlparse(url)
    return f"{p.scheme}://{p.netloc}"


def warn_missing_meta(meta, lang):
    """Live pages don't always carry every meta tag. Whatever is missing keeps the
    template's value, which is another department's — so say so loudly."""
    missing = [k for k, v in meta.items() if not v]
    if missing:
        print(
            f"Warning: {lang.upper()} live page has no {', '.join(missing)}.\n"
            f"         The template's values (another department's!) are still in place — "
            f"edit {lang}/aia/ by hand.",
            file=sys.stderr,
        )


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
    en_main_inner = rewrite_relative_urls(extract_main(en_html, "en"), url_base(args.en_url))
    fr_main_inner = rewrite_relative_urls(extract_main(fr_html, "fr"), url_base(args.fr_url))

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

    warn_missing_meta(en_meta, "en")
    warn_missing_meta(fr_meta, "fr")

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
         "main_inner": en_main_inner},
    )
    print(f"Writing {fr_out_path}", file=sys.stderr)
    render_demo(
        FR_TEMPLATE, fr_out_path, "fr",
        {**common, "title_tag": fr_title_tag, "meta": fr_meta,
         "main_inner": fr_main_inner},
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

    print("\nDone. Open both pages in a browser before committing — the demo pulls in", file=sys.stderr)
    print("canada.ca's stylesheet only, so content authored against a department's own", file=sys.stderr)
    print("theme can render differently than it does live. Also check:", file=sys.stderr)
    print("  - Any 'no description/author/...' warnings above — those leave another", file=sys.stderr)
    print("    department's metadata in the file.", file=sys.stderr)
    print("  - The breadcrumb: Canada.ca + 'Live version' by default; add a department", file=sys.stderr)
    print("    landing level in between if the page warrants one.", file=sys.stderr)
    print("  - Index entry text (department name + link text).", file=sys.stderr)
    print("  - dcterms.subject is institution-specific; the script copies the live page's value.", file=sys.stderr)


if __name__ == "__main__":
    main()
