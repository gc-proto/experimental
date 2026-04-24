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

Use `national-defence.html` or any recent file in `en/aia/` as your starting point. Copy it and name the new file to match the live page's URL slug:

```
en/aia/crown-indigenous-relations-northern-affairs.html
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

Match the breadcrumb from the live page:

```html
<nav id="wb-bc" ...>
  <ol class="breadcrumb">
    <li><a href='https://www.canada.ca/en.html'>Canada.ca</a></li>
    <li><a href='https://www.canada.ca/en/crown-indigenous-relations-northern-affairs.html'>Crown-Indigenous Relations and Northern Affairs Canada</a></li>
  </ol>
</nav>
```

## 6. Paste the main content

Get the page source of the live Canada.ca page (View Source or DevTools). Copy everything **inside** the `<main>` element — from the first `<div>` after `<main ...>` up to (but not including) `</main>`.

Paste it directly before the AI Answers banner comment block. Make sure the outer wrapper divs from the live page (`container-fluid`, `mwsgeneric-base-html`, etc.) are included and properly closed.

## 7. Keep the AI Answers banner unchanged

The banner block must stay exactly as-is, immediately after the main content:

```html
<!-- AI Answers GCWeb modal -->
<section id="top-bottom" class="wb-overlay modal-content overlay-def wb-bar-b open">
  <div class="container">
    <ul class="list-inline mrgn-bttm-sm">
      <li><img src="../img/AI-stars-30.png" alt="" /></li>
      <li><header class="p-0"><h2 class="modal-title">Need help?</h2></header></li>
      <li><a class="btn btn-default" href="https://ai-answers.alpha.canada.ca" referrerpolicy="unsafe-url">Try a beta test of AI Answers</a></li>
    </ul>
  </div>
</section>
```

Note the `referrerpolicy="unsafe-url"` attribute — this is what passes the referring page URL to the AI Answers tool.

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

- [ ] File named to match the live page URL slug
- [ ] `<head>` metadata updated (title, canonical, alternates, dcterms fields)
- [ ] Language toggle points to FR demo page (or FR live page as fallback)
- [ ] Breadcrumb matches the live page
- [ ] Main content pasted from live page source (with wrapper divs properly closed)
- [ ] AI Answers banner is present and unchanged
- [ ] Contextual footer has correct department name and contact link
- [ ] Date modified is today's date
- [ ] Entry added to `en/aia/index.html`
