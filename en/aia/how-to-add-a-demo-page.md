# How to add a new AIA demo page

These are the steps to add a new Canada.ca department page to the AI Answers demo set at `en/aia/`.

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

Same four pieces, with French text. The rescue `<h3>` becomes `Réponses IA`, the banner `<h2>` becomes `Bannière Réponses IA`, the close button label becomes `Fermer la bannière Réponses IA`, and the "Need help?" / "Ask AI Answers for help" copy becomes `Besoin d'aide ?` / `Demander de l'aide à Réponses IA`. The URL (`https://ai-answers.alpha.canada.ca`) is the same in both languages — see `fr/aia/transition-carriere-militaire.html` for the reference.

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

⚠️ Easy to miss — the `<h3>` department name and the contact link both need to change. Pages copied from older templates have shipped with stale values (e.g. "Employment Insurance") still in place.

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
- [ ] AI ANSWERS RESCUE section present inside `<main>`, just before `</main>`
- [ ] AI ANSWERS BANNER section present between `</main>` and the global footer
- [ ] AI Answers JS block kept at the end of `<body>`
- [ ] Contextual footer `<h3>` and contact link both updated to this department (not stale)
- [ ] Date modified is today's date
- [ ] Entry added to `en/aia/index.html` (alphabetical by department)
