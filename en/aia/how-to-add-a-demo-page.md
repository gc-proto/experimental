# How to add a new AIA demo page

These are the steps to add a new Canada.ca department page to the AI Answers demo set at `en/aia/`.

## Shortcut: `scrape_demo.py`

`en/aia/scrape_demo.py` automates most of the steps below. Run it from the repo root with the live EN and FR URLs:

```
python en/aia/scrape_demo.py \
  https://www.canada.ca/en/pacific-economic-development.html \
  https://www.canada.ca/fr/developpement-economique-pacifique.html
```

It fetches both pages, extracts the `<main>` content and metadata, writes `en/aia/<slug>.html` and `fr/aia/<slug>.html` using the `military-career-transition.html` demo as the template, rewrites root-relative URLs to the source department's domain, and inserts a new alphabetical entry into both index files.

**Always open both pages in a browser afterwards.** The script gets the mechanics right but can't tell whether the pasted content *renders* — see "Watch for classes from the department's own theme" under step 6.

Also review:
- **Any `Warning: … live page has no description, author, …`** the script prints. Live pages don't all carry full metadata, and whatever is missing keeps the **template's** value — i.e. National Defence's. Fill those in by hand (step 3).
- **The breadcrumb**, which the script rebuilds as `Canada.ca` + `Live version`. Add a department-landing level in between if the page warrants one (step 5).
- **The index entry text** (department name + link text).

Useful flags:
- `--en-out ircc/contact-ircc.html` / `--fr-out ircc/contactez-ircc.html` for subdirectory output
- `--en-dept-name` / `--fr-dept-name` to override the index `<h3>` text
- `--skip-index` to leave `index.html` untouched

The rest of this document explains what the script does and what to check by hand.

---

## 1. Find the live page

Go to the Canada.ca page you want to demo. Note:
- The English URL (e.g. `https://www.canada.ca/en/crown-indigenous-relations-northern-affairs.html`)
- The French URL (e.g. `https://www.canada.ca/fr/relations-couronne-autochtones-affaires-nord.html`)
- The department/institution name
- The page `<title>` and `<h1>`
- The breadcrumb path shown on the live page

## 2. Copy an existing demo page

Use `military-career-transition.html` as your starting point — it's the most recent and has the current AI Answers banner/rescue/JS pattern. Copy it and name the new file to match the live page's URL slug:

```
en/aia/crown-indigenous-relations-northern-affairs.html
```

If a department has multiple demo pages (e.g. IRCC's contact page, ISC's status card), put them in a subdirectory matching the department slug:

```
en/aia/ircc/contact-ircc.html
en/aia/sac-isc/status-card.html
```

## 3. Update the `<head>` metadata

Replace all department-specific values:

| Field | Example value |
|---|---|
| `<title>` | `Crown-Indigenous Relations and Northern Affairs Canada - Canada.ca` |
| `<link rel="canonical">` | Live page EN URL |
| `<link rel="alternate" hreflang="en">` | Live page EN URL |
| `<link rel="alternate" hreflang="fr">` | Live page FR URL |
| `name="description"` | Description from live page |
| `name="author"` | Department name |
| `name="dcterms.title"` | Page title |
| `name="dcterms.description"` | Same as description |
| `name="dcterms.creator"` | Department name |
| `name="dcterms.subject"` | Topic (e.g. `Indigenous peoples`) |
| `name="dcterms.issued"` | Original publish date |
| `name="dcterms.modified"` | Today's date |

## 4. Update the language toggle link

In the `#wb-lng` section, point the French link to the test.canada.ca equivalent:

```html
<a lang="fr" href="https://test.canada.ca/experimental/fr/aia/relations-couronne-autochtones-affaires-nord.html">
```

If the French demo page doesn't exist yet, you can leave it pointing to the live FR page as a temporary fallback.

## 5. Update the breadcrumb

The last breadcrumb item must be a link to the **live** page on canada.ca, with link text **"Live version"** (EN) or **"Version en ligne"** (FR). This is how visitors can compare the demo to production.

Above that "Live version" leaf, keep things short — usually just `Canada.ca`, optionally with one department-landing level in between. Don't replicate the live page's full breadcrumb path; the leaf is the only signal that matters.

```html
<nav id="wb-bc" property="breadcrumb">
  <h2 class="wb-inv">You are here:</h2>
  <div class="container"><ol class="breadcrumb">
    <li><a href='https://www.canada.ca/en.html'>Canada.ca</a></li>
    <li><a href='https://www.canada.ca/en/department-national-defence.html'>National Defence</a></li>
    <li><a href='https://www.canada.ca/en/department-national-defence/services/benefits-military/transition.html'>Live version</a></li>
  </ol></div>
</nav>
```

For a top-level department landing where there's no parent, just `Canada.ca` + `Live version` is fine (see `canada-revenue-agency.html`).

## 6. Paste the main content

Get the page source of the live Canada.ca page (View Source or DevTools). Copy everything **inside** the `<main>` element — from the first `<div>` after `<main ...>` up to (but not including) `</main>`.

Paste it directly before the AI Answers banner comment block. Make sure the outer wrapper divs from the live page (`container-fluid`, `mwsgeneric-base-html`, etc.) are included and properly closed.

### Rewrite relative URLs to absolute

Department source pages often use **root-relative** links and image paths (e.g. `href="/en/support-businesses"`, `src="/sites/default/files/img/photo.jpg"`). Because the demo is hosted under `test.canada.ca/experimental/`, those resolve against the wrong host and break. Rewrite every root-relative `href`/`src` in the pasted content to an **absolute URL on the source department's domain**:

```
/en/support-businesses              → https://fednor.canada.ca/en/support-businesses
/sites/default/files/img/photo.jpg  → https://fednor.canada.ca/sites/default/files/img/photo.jpg
```

Leave already-absolute URLs (e.g. `https://www.canada.ca/...`, `https://x.com/...`) untouched. Drupal `data-entity-*` attributes on the source links can be dropped — only the `href` matters for the demo.

### Watch for classes from the department's own theme

A demo page loads **canada.ca's `theme.min.css` and nothing else**. Departments on their own domain (tc.canada.ca, fednor.canada.ca) style their pages with theme classes that don't exist in that stylesheet, so pasted content using them renders unstyled — silently, with no error.

The Transport Canada "Most requested" list is the worked example. Its source markup was:

```html
<ul class="wb-eqht list-unstyled mrgn-tp-md mrgn-bttm-sm lst-spcd-1 list-responsive-3">
```

`list-responsive-3` is what makes it three columns on tc.canada.ca and means nothing on canada.ca, and `list-unstyled` removes the bullets — so the list rendered as one long unbulleted stack. The fix is to rewrite the section in the canada.ca pattern (see `treasury-board-secretariat.html`):

```html
<section class="well well-sm provisional gc-most-requested">
  <div class="container">
    <div class="row">
      <div class="col-md-2"><h2>Most requested</h2></div>
      <div class="col-md-10">
        <ul class="colcount-md-2">
          <li><a href="…">…</a></li>
        </ul>
      </div>
    </div>
  </div>
</section>
```

⚠️ **The column count is not yours to choose here.** `.gc-most-requested ul` in `theme.min.css` hard-sets `column-count: 2`, and it outranks any `colcount-*` class on the same list — `.gc-most-requested ul` (specificity 0,1,1) beats `.colcount-md-3` (0,1,0). So `colcount-md-2` in the markup above is decorative; TBS carries the same redundant class. Adding `colcount-md-3` to get three columns **does nothing**. A department landing page whose live version is three columns will be two columns as a demo, which is correct — the demo follows the canada.ca pattern, not the department's.

More generally: if pasted content looks wrong, check whether the class doing the work is a canada.ca class or the department's, before assuming the markup is broken.

### Append "(demo)" to the H1

The H1 — the `<h1 ... id="wb-cont">` you just pasted — must end with `(demo)` in English or `(démo)` in French. This labels the page as not-the-real-thing for anyone who lands on it.

```html
<h1 property="name" id="wb-cont">Military career transition (demo)</h1>
```

```html
<h1 property="name" id="wb-cont">Transition de carrière pour les militaires (démo)</h1>
```

## 7. Keep the AI Answers pieces unchanged

The AI Answers integration is **four separate pieces** that all need to stay in place. If you started from `military-career-transition.html` they're already there — just leave them alone. The summary below is so you know what to look for.

> **Source of truth:** the canonical CDTS reference is `jmtesting/ai-answers/local-copy/citation-work/for-review/CDTS.html`. The demo pages in `en/aia/` mirror its CSS, RESCUE/BANNER markup, and JavaScript. If you need to update the pattern across all demos, start from that file.

### a. CSS in `<head>`

A `<style>` block (~100 lines) defining `.aia-banner`, `.aia-rescue`, `.aia-close`, `body.aia-banner-visible #wb-info`, and mobile media queries. Look for the `<!-- AI Answers CSS -->` comment.

### b. RESCUE section — inside `<main>`

Placed just before `</main>`, after the page's main content. Wrapped in `<div class="container">`:

```html
<!-- AI ANSWERS RESCUE -->
<div class="container">
  <section class="aia-rescue">
    <h3 class="wb-inv">AI answers</h3>
    <div class="d-flex align-items-center">
      <img src="https://canada.ca/content/dam/canada/ai-stars-blue.png" alt="">
      <p><strong>Need help?</strong> <a href="https://ai-answers.alpha.canada.ca" referrerpolicy="unsafe-url">Ask AI Answers for help</a></p>
    </div>
  </section>
</div>
```

### c. BANNER section — outside `<main>`

Placed between `</main>` and the `<div class="global-footer">`:

```html
<!-- AI ANSWERS BANNER -->
<section class="aia-banner">
  <h2 class="wb-inv">AI answers banner</h2>
  <div class="container">
    <div class="d-flex align-items-center">
      <img src="https://canada.ca/content/dam/canada/ai-stars.png" alt="">
      <p><strong>Need help?</strong> <a href="https://ai-answers.alpha.canada.ca" referrerpolicy="unsafe-url">Ask AI Answers for help</a></p>
    </div>
  </div>
  <button class="aia-close" type="button" aria-label="Close AI answers banner">×</button>
</section>
```

### d. JavaScript at end of `<body>`

A `<script>` block after the WET/jQuery script tags. It pings `ai-answers.alpha.canada.ca/api/chat/chat-session-availability`, removes both `.aia-banner` and `.aia-rescue` elements if AI Answers isn't available, waits for the footer to exist, then adds the `aia-banner-visible` class to `<body>` and wires up the close button. Look for the `<!-- AI ANSWERS JAVASCRIPT -->` comment.

### French pages (`fr/aia/`)

Same four pieces, with French text. The rescue `<h3>` becomes `Réponses IA`, the banner `<h2>` becomes `Bannière Réponses IA`, the close button label becomes `Fermer la bannière Réponses IA`, and the "Need help?" / "Ask AI Answers for help" copy becomes `Besoin d'aide ?` / `Demander de l'aide à Réponses IA`.

**The URL is different in each language** — FR demos must link to `https://reponses-ia.alpha.canada.ca` (not `https://ai-answers.alpha.canada.ca`, which is the EN site). This applies to **all three** spots the URL appears in the FR template: the rescue link, the banner link, and the JavaScript availability-check `fetch()`. See `fr/aia/transition-carriere-militaire.html` for the reference.

Note the `referrerpolicy="unsafe-url"` attribute on the AI Answers links — this is what passes the referring page URL to the AI Answers tool.

## 8. Update the contextual footer

Replace the department name and contact link in `gc-contextual`:

```html
<div class="gc-contextual">
  <nav>
    <h3>Crown-Indigenous Relations and Northern Affairs Canada</h3>
    <ul ...>
      <li><a href="https://www.rcaanc-cirnac.gc.ca/eng/1603225519672">Contact Crown-Indigenous Relations and Northern Affairs Canada</a></li>
    </ul>
  </nav>
</div>
```

⚠️ Easy to miss — the `<h3>` department name and the contact link both need to change, and **`scrape_demo.py` does not do this for you**. It's near the bottom of the page, below the fold, so nothing about a page that looks fine tells you it's wrong. Pages have shipped with stale values still in place (e.g. "Employment Insurance"); a page built from the current template will say "National Defence" until you change it.

## 9. Update the date modified

```html
<gcds-date-modified>
  2026-04-23
</gcds-date-modified>
```

## 10. Add the page to the index

Open `en/aia/index.html` and add a new `<section>` block inside the `<div class="row mrgn-tp-lg">`, following the same pattern as existing entries:

```html
<section class="col-md-6 mrgn-bttm-lg">
<h3>Crown-Indigenous Relations and Northern Affairs Canada (CIRNAC)</h3>
<ul>
<li>Demo page: <a href="https://test.canada.ca/experimental/en/aia/crown-indigenous-relations-northern-affairs.html">Crown-Indigenous Relations and Northern Affairs Canada (test)</a></li>
<li>Live page: <a href="https://www.canada.ca/en/crown-indigenous-relations-northern-affairs.html">Crown-Indigenous Relations and Northern Affairs Canada</a></li>
</ul>
</section>
```

Keep entries alphabetical by department name.

---

## Quick checklist

- [ ] File named to match the live page URL slug (in a department subdirectory if there will be multiple demos for that department)
- [ ] `<head>` metadata updated (title, canonical, alternates, dcterms fields)
- [ ] AI Answers CSS `<style>` block kept in `<head>`
- [ ] Language toggle points to FR demo page (or FR live page as fallback)
- [ ] Breadcrumb ends with a "Live version" / "Version en ligne" link to the live page on canada.ca
- [ ] H1 ends with `(demo)` / `(démo)`
- [ ] Main content pasted from live page source (with wrapper divs properly closed)
- [ ] Root-relative `href`/`src` in the pasted content rewritten to absolute URLs on the source department's domain
- [ ] **Both pages opened in a browser** — content styled with the department's own theme classes renders unstyled on canada.ca and fails silently
- [ ] AI ANSWERS RESCUE section present inside `<main>`, just before `</main>`
- [ ] AI ANSWERS BANNER section present between `</main>` and the global footer
- [ ] AI Answers JS block kept at the end of `<body>`
- [ ] **FR pages only:** all three AI Answers URLs (rescue link, banner link, JS fetch) point to `reponses-ia.alpha.canada.ca`, not `ai-answers.alpha.canada.ca`
- [ ] Contextual footer `<h3>` and contact link both updated to this department (not stale)
- [ ] Date modified is today's date
- [ ] Entry added to `en/aia/index.html` (alphabetical by department)
