# Canada Strong tariff support tool — how it works

A wb-fieldflow wizard that routes businesses affected by U.S. tariffs to the federal
programs that fit them. Built from `canada-strong-tariff-tool-LB_Sept_01.pdf`, then
corrected against `tariff-tool-links.csv`, which is the researched source of truth.

Live on test.canada.ca:

| | |
|---|---|
| [start-en.html](https://test.canada.ca/experimental/canada-strong/start-en.html) | the splitter question |
| [business-en.html](https://test.canada.ca/experimental/canada-strong/business-en.html) | the four-question wizard |
| [start-fr.html](https://test.canada.ca/experimental/canada-strong/start-fr.html) | page de départ |
| [business-fr.html](https://test.canada.ca/experimental/canada-strong/business-fr.html) | assistant pour les entreprises |

## The short version — which file do I edit?

| I want to… | Edit |
|---|---|
| Add, move, retire or re-link a **program** | `_data/tariff_tool_links.csv` |
| Fix a **program name or URL**, in either language | `_data/tariff_tool_links.csv` |
| Change a **question, answer, heading or label** | `_data/canada_strong_en.yml` / `_fr.yml` |
| Change the **eligibility criteria** or which size shows which badge | the same two YAML files |
| Change **layout or markup** | `business-*.html` / `start-*.html` |
| Check you did not break anything | `ruby _tests/run.rb` |

The four HTML files contain no copy and no program data. Both languages share one CSV.
Paths below are relative to this folder (`canada-strong/`), which is meant to be worked
on and copied as a unit — see "This folder stands alone" below.

```
_data/tariff_tool_links.csv    59 rows — every program, both languages, and its routing
_data/canada_strong_en.yml     English interface text + eligibility rules
_data/canada_strong_fr.yml     the same, in French
start-*.html                   three choices, links out
business-*.html                the wizard: questions, generated results, generated CSS
_tests/                        the suite: 116 tests over the files above
how-this-wizard-works.md       this file
```

`business-fr.html` is `business-en.html` with three lines changed — the data file it reads,
and `NAME` / `URLF` pointing at the CSV's `name_fr` and `url_fr` columns. Keep them in step.

## This folder stands alone

Everything to work on this prototype lives inside `canada-strong/`: the four pages, the
copy and routing data in `_data/`, the docs, and the test suite in `_tests/`. Someone can
copy this one folder out — to pull into AEM, hand to another team, whatever — and it works
on its own; `_tests/test_standalone.rb` checks exactly that.

Two things make it work:

- **`_config.yml` at the repo root** sets `data_dir: canada-strong/_data`, which is what
  lets Jekyll find `site.data.canada_strong_en` and friends from inside this folder rather
  than the repo-root `_data/` it defaults to. Jekyll only allows one `data_dir` for the
  whole site, and canada-strong is the only thing in this repo that uses `site.data`, so
  this doesn't collide with anything else.
- **The underscore on `_data/` is load-bearing.** Jekyll skips any folder starting with
  `_` when it copies files into the built site. Without it, `tariff_tool_links.csv` — internal
  research notes and all, see the `note` column below — would be a fetchable file on
  test.canada.ca. The test suite lives in `_tests/` for the same reason.

If this folder is copied somewhere Jekyll never runs, `_tests/support/wizard.rb` falls back
to reading `canada-strong/_data` directly, so the suite still runs; the three tests that
check `_config.yml` itself skip in that case.

## The CSV is the routing table

Each row is one program, and its `need`, `sector` and `region` columns *are* the routing.
Nothing else decides what a combination returns.

| Column | Meaning |
|---|---|
| `need` | `financing`, `liquidity`, `transformation`, `workforce`, or `all` for a hub shown under every need. Semicolons for more than one — the regional rows use `liquidity;transformation`. |
| `sector` | `sector-agnostic`, `agriculture`, `forestry-and-lumber`, `steel-and-aluminum` |
| `region` | `national`, or one of the seven RDA regions |
| `size` | blank by default — shown for every size. Set to restrict a row: `under-1m`, `nonprofit`, `1to5m`, `5mplus`, `large`, semicolons for more than one. LETL (`large`) and AgriMarketing's SME/NIA split use this today. |
| `program_name` / `name_fr` | what the user sees. Blank `name_fr` falls back to English so a gap is visible, not silent. |
| `url_en` / `url_fr` | where the link goes |
| `status` | research confidence. `no-page` and `disputed` are **not rendered** — see below |
| `note` | internal research notes. **Never rendered.** Say anything you like here. |
| `slide_label` | what the original deck called it, for tracing back. Not used at build time. |

**Adding a program is one row.** No YAML change, no template change.

### `status` decides what ships

`exclude_statuses: "no-page disputed"` in both YAML files drops those rows entirely. That
single line is the whole forestry fix: the deck named a BDC forestry transformation stream
the department does not actually route to, the CSV marked it `disputed`, and four NRCan
programs (IFIT, Forest Innovation, GCWood, Global Forest Leadership) took its place. To
bring a dropped row back, take its status out of that list.

Other statuses (`verified`, `added`, `weak`, `ambiguous`, `best-guess`, `duplicate-url`)
all render. They are confidence notes for you, not switches.

`route` rows are special: they mark a cell researched and confirmed to have no
sector-specific stream. The sector-specific panel is simply omitted for that
need — no panel, no "no stream for your sector" box — and the business still sees
whatever the sector-agnostic column, region and hubs have for that need. A `route`
row's only job is telling you the empty cell was checked, not missed; it changes
nothing at build time. (An empty cell without a `route` row renders exactly the same
way, so adding one is a research note to leave for the next person, not a fix.)

## How a combination becomes a visible panel

Results depend on **two answers at once** — the need and the sector — and a fieldflow
option can only reveal one fixed target. So:

1. Each answer stamps a **marker class** on `#wz-state`: `need-liq`, `sec-agri`,
   `reg-on-s`, `size-1to5m`. Twenty markers, one per answer.
2. At build time the template groups the CSV into a panel per need × sector, per region,
   and per sector hub. Every panel is in the DOM, hidden by `.wz-r { display: none }`.
3. It also generates one CSS rule per panel, which is what reveals it:

```css
#wz-state.need-liq.sec-agri .wz-p-liquidity-agriculture { display: block; }
```

`#wz-state.need-liq.sec-agri` (specificity 1,3,0) outranks `.wz-r` (0,1,0), so the matching
panel wins. No JavaScript of our own — fieldflow stamps the classes, CSS does the rest.

The generated `<style>` block opens with a **grid comment counting each cell**, so you can
still check the shape at a glance without maintaining it by hand:

```
forestry-and-lumber | financing=0 | liquidity=2 | transformation=4 | workforce=0
steel-and-aluminum  | financing=0 | liquidity=1 | transformation=0 | workforce=0
agriculture         | financing=2 | liquidity=5 | transformation=5 | workforce=0
```

**Resetting.** Each question's `clears:` string lists every marker it invalidates.
Question 1 clears all twenty, question 2 clears region, size and sector, and so on. This
is what stops a stale panel surviving when someone changes an earlier answer.

## How a size-gated row hides itself

Everything above works at the level of a whole panel. Size doesn't get its own panel — a
size-restricted program (LETL) sits in a panel that's already visible for other reasons
(the sector-agnostic liquidity column, say), so what needs hiding is one `<li>`, not the
section around it.

Each `<li>` checks its own row's `size` column at build time. If it's blank, nothing
changes — the `<li>` has no class and is never hidden, exactly like before this existed. If
it's set, the `<li>` gets `wz-sz` (hidden by default, same idea as `.wz-r`/`.wz-rb`) plus
one `wz-sz-{{ marker }}` class per size the row lists:

```liquid
<li{% if r.size and r.size != "" %} class="wz-sz{% assign r_sizes = r.size | split: ";" %}{% for sz in t.sizes %}{% if r_sizes contains sz.csv %} wz-sz-{{ sz.marker }}{% endif %}{% endfor %}"{% endif %}>
```

and one generated CSS rule per size marker reveals it, same pattern as the sector hubs:

```css
#wz-state.size-large .wz-sz-size-large { display: list-item; }
```

**The blank check has to be `r.size and r.size != ""`, not just `!= ""`.** A blank CSV
cell parses as Ruby `nil`, and in Liquid `nil != ""` is true — so a bare `!= ""` check
would tag *every* row, including the hundreds with nothing in `size`, with an unmatchable
`wz-sz` class and hide them all. `r.org != ""` had the same latent bug (dormant, since no
rendered row has ever had a blank org); both checks now guard the nil case first.

**The size match has to split on `;` before comparing, not use `contains` on the raw
string.** Liquid's `contains` is substring matching against a string but exact-element
matching against an array — `r.size | split: ";"` makes it an array first. With today's
five size codes none is a substring of another, so the raw-string version happened to work,
but it's the same class of bug as the blank check above: correct by accident, not by
construction. `Expected.size_ok?` on the Ruby side already split and compared exactly; the
template didn't match it until this was caught in review.

**A panel's own visibility and a row's size gating are two separate mechanisms**, decided
at different points (need/sector/region for the panel, `size` for the `<li>`s inside it).
Nothing stops a CSV edit from restricting every row in a panel to sizes that don't add up
to "everyone" — the panel would still render, heading and all, with an empty body for
whichever size that leaves out. Not a live bug — every panel today has at least one row
visible at every size — but a spreadsheet edit could cause it silently, so
`test_no_panel_ever_renders_with_zero_visible_programs` checks the invariant directly
rather than trusting it to hold by accident, the same reasoning as the two bugs above.

## The vocabulary bridge

The YAML's `needs`, `sectors` and `regions` map our markers to the CSV's own words. Rename
a value in the spreadsheet and you change it here too — in **both** language files, because
the `csv:` values are identifiers and stay English in the French file.

```yaml
needs:
  - {marker: need-liq, csv: liquidity, heading: "Liquidity"}
sectors:
  - {marker: sec-agri, csv: agriculture, heading: "Agriculture"}
regions:
  - {marker: reg-atl,  csv: "Atlantic"}
  - {marker: reg-on-n, csv: "Northern Ontario"}   # its own RDA (FedNor); see below
```

A marker can map to several CSV values at once — semicolons for "regional criteria use
this region OR that one" — but Ontario isn't that: it's two RDAs with two different
regional programs, so it's two separate answers (`reg-on-n`, `reg-on-s`), each mapping to
exactly one CSV region. One marker with `"Southern Ontario;Northern Ontario"` would show a
Southern Ontario business FedNor's program too, and vice versa.

Manufacturing and the U.S.-exporter answer are deliberately absent from `sectors:` — they
have no sector-specific stream, so they see the sector-agnostic results only.

There's a fourth bridge, `sizes:`, the same shape as the other three. It exists only for
the rare CSV row that restricts itself by size (the `size` column above) — every row
without one ignores it completely, which is nearly all of them. Unlike need/sector/region,
size is never the *only* thing gating a row: it narrows an already-visible panel's list,
one `<li>` at a time, rather than showing or hiding a whole panel — see "How a size-gated
row hides itself" below.

## Gotchas found the hard way

- **fieldflow's generated markup is a sibling, not a child.** After init, `#question-1` is
  hidden and the real `<fieldset>` is inserted *next to* it. `#question-1 input[type=radio]`
  finds nothing. This looks like total failure and is not.
- **Do not use Bootstrap's `.hidden` for anything the generated rules control.** It is
  `display: none !important`, which no rule can override. That is why panels use `.wz-r`.
  `.hidden` is still right for `#wz-results` as a whole, which fieldflow toggles directly.
- **Liquid has no `not`.** The exclusion list is applied by chaining one `where_exp` per
  status, which is why that loop looks odd:
  ```liquid
  {%- for st in excluded -%}{%- assign live = live | where_exp: "r", "r.status != st" -%}{%- endfor -%}
  ```
- **`where` and `where_exp` are Jekyll filters, not core Liquid.** They work on
  GitHub Pages; they do not exist in the bare `liquid` gem, so anything rendering these
  templates outside Jekyll has to define them or local and deployed silently diverge.
  `_tests/support/wizard.rb` is the one place that does.
- **The CDTS theme is served from `cdts.service.canada.ca`, not `www.canada.ca`.** It
  bundles wb-fieldflow including `gcChckbxrdio`, so no extra `<script>` is needed. The old
  local copy at `en/assets/wb-fieldflow.min.js` predates `gcChckbxrdio`; do not use it.
- **French pages must load `wet-fr.js`**, not `wet-en.js`, or WET's own strings — the
  "(required)" after each legend — come out in English on a French page.
- **French puts a space before a colon.** Panel headings are assembled from parts, so the
  separator is `labels.heading_sep`: `": "` in English, `" : "` in French.
- **`layout: null`** in the front matter is what runs Liquid while letting the raw CDTS
  HTML through. With no front matter at all, Jekyll copies the file verbatim and the Liquid
  tags ship to the browser as literal text.

## Tests

`_tests/` covers everything below that does not need a browser.
No Jekyll: the harness renders these templates with the same Liquid and the same two
Jekyll array filters the real build uses, so it sees the bytes that ship.

```bash
ruby _tests/run.rb          # the whole suite
ruby _tests/preview.rb out  # render the pages to ./out to look at them
```

Both need the `liquid` and `nokogiri` gems, already installed on the team's machines
(`gem install --user-install liquid -v 4.0.4 --no-document` if not). CI runs the suite
on every push and pull request, before the Jekyll build.

To look at the output, `python3 -m http.server` from the directory `preview.rb` wrote —
a local server is required, the CDTS closure scripts do not run reliably from `file://`.

`_tests/README.md` says what each test file covers. In short:

- **All 700 combinations** (140 need x region x sector, crossed with every size answer),
  both languages. It parses the generated CSS back out of the
  page, works out which panels a set of answer markers reveals, and diffs the programs
  in them against the CSV — which it reads through a second, separate implementation of
  the rules on this page, so it cannot just agree with the template's bugs.
- **The CSV**: required columns, closed vocabularies for need / sector / region / status,
  https URLs, French coverage on every row that renders, no untriaged duplicate
  destinations.
- **Eligibility**: exactly one badge per criterion for all twenty size x sector pairs,
  nothing painted before its question is answered, and exactly one RDA link — the right
  one — for whichever region was chosen.
- **Markup**: one h1 and no skipped heading levels, the fieldflow chain, the reset
  cascade, and each gotcha listed above — `.hidden` on a generated-rule target, the wrong
  `wet-*.js`, the missing space before a French colon, missing `layout: null`.
- **Parity**: the French templates are the English ones with the language swapped, and
  the two YAML files stay the same shape.

Two tests pin decisions rather than data — the forestry transformation cell routing to
NRCan and not BDC, and the duplicate-URL triage. Data-driven tests cannot catch those:
both sides read the same CSV, so changing the CSV changes the expectation too. If one of
those decisions is genuinely revisited, delete the test on purpose.

## Verifying a change

Run the suite. What is left needs a browser, because wb-fieldflow builds the radios,
fieldsets and legends at runtime — before init there is nothing in the static HTML to
find.

Do **not** click through every combination: fieldflow re-renders on each answer and a
backgrounded Chrome tab throttles timers hard enough that a click-driven sweep takes
minutes and produces confusing intermediate states. The suite already covers all 120.

Click one full path by hand instead, watching `document.getElementById("wz-state").className`
after each answer. Then change an earlier answer and confirm the cascade clears and the
results re-hide. Check the generated radios sit inside a `<fieldset>` with a `<legend>`,
and that layout holds at a 390px viewport.

## Where the content came from, and what we changed

The deck was the starting point; the CSV corrected it. Deliberate departures:

- **Slide 3 is not a separate page.** Those employer workforce programs are the workforce
  column, which is where the deck says the employer gets directed.
- **Slide 5 is not built.** The worker choice links to the live Canada.ca page.
- **The start page does not use slide 1's card layout.** Cards were a deck artifact, not
  design intent. Each choice is now a label, one line of text and a `btn btn-primary`. The
  label is deliberately not also a link — that would put two adjacent links to the same
  destination in every choice.
- **Amount, term and repayment are not shown.** Slide 4 asks for them; no figures exist
  yet, and inventing them on a Canada.ca-looking page is not acceptable.
- **The forestry transformation cell is the deck's, corrected.** See `status` above.
- **Ontario is two region answers, not one.** The deck's region question (and an earlier
  version of this page) asked once for "Ontario". Ontario has two regional development
  agencies with two different regional programs — FedNor for the north, FedDev Ontario for
  the south (see
  [Canada's regional development agencies](https://ised-isde.canada.ca/site/ised/en/canadas-regional-development-agencies))
  — so one answer would have shown every Ontario business both agencies' regional program.
  The split is at Muskoka, with the answer labels naming the boundary and Parry Sound
  explicitly, since that's the district people are most likely to be unsure about.
- **The eligibility section ends with a link to the business's own RDA.** Not the region's
  tariff-specific program — that's already linked above, under "Programs for your region" —
  but the agency's own homepage, added because the RDA is worth pointing to regardless of
  what the CSV's programs turn up for that need. It's not deck content: `regions:` in each
  YAML gained `rda` and `rda_url` fields alongside the marker and `csv` value, names taken
  from each page's own `<h1>`, all seven URLs checked live on 2026-09-03. The paragraph for
  every region is in the DOM at once, one `#wz-state.reg-marker .wz-rda-reg-marker` rule
  each, same pattern as the sector hubs' `.wz-hub-*` rule just above it.
- **An empty sector cell shows nothing, not a "no stream" box.** The original design put
  up a panel reading "No stream specific to your sector" for the six need x sector
  combinations the CSV has no dedicated program for. In practice a box announcing an
  absence, next to panels announcing programs, read as a mistake rather than information —
  the business still gets the sector-agnostic results for that need either way, so the box
  said nothing they needed. `route_heading` / `route_body` and the `wz-route-*` markup are
  gone; the `route` status in the CSV stays, as a research note that the empty cell was
  checked rather than missed — see `status` above.
- **Question 3 has a fifth answer for organizations, not just businesses by size.** The
  Regional Tariff Response Initiative is also open to "non-profit organizations, industry
  and sector associations, boards of trade, and provincial entities that support affected
  businesses" — the provincial-entities part is left out of the label on purpose, per
  direction. It sits right after "Under $1 million," and is mapped to that same answer's
  eligibility badges (`size-nonprofit` uses `size-under1m`'s `eligibility_rules` rows) as a
  placeholder until there's real guidance for this group specifically —
  `test_nonprofit_size_answer_matches_under1m_badges` pins that so it can't drift quietly.
  At the time this was written size only changed the eligibility badges, never which
  programs showed — the next entry is why that's no longer true.
- **Size can now gate an individual program, not just badges.** LETL's own research note
  said "Large enterprise only - gate on the Q3 size answer" and nothing did. The CSV gained
  a `size` column (blank means shown to everyone, which is nearly every row) and LETL is
  set to `large`. See "How a size-gated row hides itself" above for the mechanism, and
  `test_letl_only_shows_for_size_large` for the pin.
- **AgriMarketing's SME and NIA rows now split on the `size-nonprofit` answer.** The NIA
  row (Market Diversification for National Industry Associations) was already in the CSV,
  flagged with *"Associations only, not individual businesses"* and no way to act on that —
  this tool asks "I am a business or employer," so it could show to everyone. It's now
  `size: nonprofit`; the SME row is every other size. This is also why `size-nonprofit`
  needed its own bucket in the `sizes:` bridge rather than sharing `size-under1m`'s — two
  programs that both restrict by size, one to "actual businesses under $1M" and one to
  "non-profits," would otherwise be indistinguishable to the routing mechanism, even though
  their eligibility badges still deliberately share size-under1m's as a placeholder. Pinned
  by `test_agrimarketing_sme_and_nia_are_mutually_exclusive`.

## Next steps

1. **Spot-check the nine composed French names.** 43 of 52 were read off the live French
   page's own `<h1>`, cleaned of taglines, org suffixes and AAFC's ": 1. Ce qu'offre ce
   programme" step numbering. The `fr_source` column records the provenance of every row;
   the eight marked `composed:` carry the reason, and they are the only ones needing a
   French-language judgement call:
   - three regional IRRT pages whose own h1 omits the region
   - two stream names whose parent page covers several streams
   - CEEFC, whose h1 is the corporation name rather than the product
   - the Business Benefits Finder, whose page has no h1 at all
   - FCC's French financing page, which still carries an English title
   ("Marque Canada" is confirmed correct — its site was simply down when checked.)
2. **Resolve the remaining flagged rows.** `duplicate-url` (3), `weak` (2), `ambiguous` (1)
   and `best-guess` (1). Each `note` says what the doubt is. The `duplicate-url` rows in
   particular send two differently-named results to the same page, which reads as a bug.
3. **Report the AAFC language-toggle bug.** One note records that the French AAFC hub's
   English toggle targets a 404. That is a live Canada.ca defect, unrelated to this work.
4. **Add amount, term and repayment** once the figures exist — new CSV columns and a line
   in the template.
5. **The start page does not fit a phone screen.** Each choice measures 143px at a 390px
   viewport, putting the third button about 872px down, past the ~724px a mobile browser
   leaves visible. The 271px of CDTS header and breadcrumb is most of that budget. Cheapest
   fixes: shorten each `description` to one line at 360px (~78px), drop the intro line
   (~33px), tighten the gap to `mrgn-bttm-sm` (~20px). Buttons cost only 12px more than
   plain links, so they are not the thing to cut.
6. **Consider a worker path prototype** if that page needs design work rather than a link.
7. **Give `size-nonprofit` its own eligibility badges** once there's real guidance for
   non-profits, associations and boards of trade — it currently borrows `size-under1m`'s as
   a placeholder (see "what we changed"), and "3 or more years operating" / "$1 million or
   more in annual revenue" are business-shaped criteria that may not fit this group at all.
8. **Consider the Kosher and Halal Investment Component** as a third AgriMarketing row.
   Research on the SME/NIA split turned this up as a further stream under the same
   program, sector-specific rather than size-specific — not added, since its own URL and
   French name still need the same live-page verification every other row got.
