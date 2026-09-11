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
| Change **layout or markup** | `business-*.html` / `start-*.html` |
| Check you did not break anything | `ruby _tests/run.rb` |

The four HTML files contain no copy and no program data. Both languages share one CSV.
Paths below are relative to this folder (`canada-strong/`), which is meant to be worked
on and copied as a unit — see "This folder stands alone" below.

```
_data/tariff_tool_links.csv    60 rows — every program, both languages, and its routing
_data/canada_strong_en.yml     English interface text
_data/canada_strong_fr.yml     the same, in French
start-*.html                   three choices, links out
business-*.html                the wizard: questions, generated results, generated CSS
_tests/                        the suite: 136 tests over the files above
how-this-wizard-works.md       this file
```

`business-fr.html` is `business-en.html` with four lines changed — the data file it reads,
and `NAME` / `URLF` / `ORGF` pointing at the CSV's `name_fr`, `url_fr` and `org_fr`
columns. Keep them in step; `test_parity` normalises exactly those four and fails on a fifth.

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
| `need` | `financing`, `liquidity`, `transformation`, `workforce`, `hiring`, `all` for a hub shown under every need, or `featured` for the one promoted row that closes the More options panel. Semicolons for more than one — the regional rows use `liquidity;transformation`. |
| `sector` | `sector-agnostic`, `agriculture`, `forestry-and-lumber`, `steel-and-aluminum` |
| `region` | `national`, or one of the seven RDA regions |
| `size` | blank by default — shown for every size. Set to restrict a row: `under-1m`, `nonprofit`, `1to5m`, `5mplus`, `20mplus`, `large`, semicolons for more than one. LETL, AgriMarketing's SME/NIA split, three BDC programs (Pivot to Grow Loan, Steel and Aluminium, Softwood Lumber Guarantee), EDC direct lending, and six of the seven RTRI rows (all but Quebec) use this today. |
| `program_name` / `name_fr` | what the user sees. Blank `name_fr` falls back to English so a gap is visible, not silent. |
| `url_en` / `url_fr` | where the link goes |
| `org` / `org_fr` | the department credited after the link. Blank `org_fr` falls back to `org`, the same contract as `name_fr` — correct for the acronyms that do not change in French (BDC, EDC, CanNor, FedNor, PacifiCan, PrairiesCan, FIN, CED / DEC, CEEFC / CDEV, FedDev Ontario) and wrong for anything else. |
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
   `reg-on-s`, `size-1to5m`. Twenty-three markers, one per answer.
2. At build time the template groups the CSV into a panel per need × sector, per region,
   and per sector hub. Every panel is in the DOM, hidden by `.wz-r { display: none }`.
3. It also generates one CSS rule per panel, which is what reveals it:

```css
#wz-state.need-liq.sec-agri .wz-p-liquidity-agriculture { display: block; }
```

`#wz-state.need-liq.sec-agri` (specificity 1,3,0) outranks `.wz-r` (0,1,0), so the matching
panel wins. No JavaScript of our own — fieldflow stamps the classes, CSS does the rest.

Sector-cell and regional panels carry a fourth class for the size answer
(`…need-liq.sec-steel.size-1to5m…`), and are emitted only for sizes that actually have a
qualifying row — see "How a size-gated row hides itself" for why. The specificity argument
is unchanged; it only goes up.

The generated `<style>` block opens with a **grid comment counting each cell**, so you can
still check the shape at a glance without maintaining it by hand:

```
forestry-and-lumber | financing=0 | liquidity=2 | transformation=4 | workforce=0
steel-and-aluminum  | financing=0 | liquidity=1 | transformation=0 | workforce=0
agriculture         | financing=2 | liquidity=5 | transformation=5 | workforce=0
```

**Resetting.** Each question's `clears:` string lists every marker it invalidates.
Question 1 clears all twenty-one, question 2 clears region, size and sector, and so on.
This is what stops a stale panel surviving when someone changes an earlier answer.

## "All of the above" is a second set of panels

Question 1's last answer, `need-all`, is not a need. It has no `needs:` entry, no `csv`
value, and no CSV row is filed under it — `all_needs_marker` in both YAML files is the
one place it is named.

What it shows is **every row that applies to the visitor's sector, region and size,
exactly once**, still grouped under the four need headings. Getting there needs its own
panels — `wz-ap-<need>-<sector>`, `wz-ap-<need>-agnostic`, `wz-arg-<region>` — generated
alongside the per-need ones and revealed only by `#wz-state.need-all…`. Two reasons:

- **A program can serve two needs.** Eight rows do: the Pivot to Grow Loan is
  `financing;liquidity`, and all seven RTRI rows are `liquidity;transformation`. Revealing
  the per-need panels together would list each of them twice. In the all-view each row is
  emitted **under the first need its `need` cell names** and skipped in the others, so the
  order inside a semicolon-separated cell now carries meaning: reorder it to move a
  program between headings.
- **Two conditional CSS mechanisms on one `<li>` compose as OR, not AND.** The obvious
  cheaper fix — keep the per-need panels and hide the duplicate `<li>` with a second
  class — cannot work here. Both `.wz-sz` size gating and any dedup class are "hidden by
  default, revealed by a marker rule", so a row that is size-hidden *and* duplicate would
  be revealed by the rule that does match. Deciding it at build time sidesteps the
  cascade entirely.

The regional panel is the one place the all-view has **one panel where the per-need view
has several**: its heading, "Programs for your region", names no need, so two of them
would read as the same box printed twice.

`test_all_of_the_above_is_exactly_the_union_of_the_four_needs` is the guard, and it
checks the claim the answer actually makes to the visitor: what they see equals what the
four separate answers would have shown them, with nothing extra.

## How a size-gated row hides itself

Everything above works at the level of a whole panel. Size doesn't get its own panel — a
size-restricted program (LETL) sits in a panel that's already visible for other reasons
(the sector-agnostic liquidity column, say), so what needs hiding is one `<li>`, not the
section around it.

Each `<li>` checks its own row's `size` column at build time. If it's blank, nothing
changes — the `<li>` has no class and is never hidden, exactly like before this existed. If
it's set, the `<li>` gets `wz-sz` (hidden by default, same idea as `.wz-r`) plus one
`wz-sz-{{ marker }}` class per size the row lists:

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
six size codes none is a substring of another, so the raw-string version happened to work,
but it's the same class of bug as the blank check above: correct by accident, not by
construction. `Expected.size_ok?` on the Ruby side already split and compared exactly; the
template didn't match it until this was caught in review.

That review fixed the `<li>` gating but missed the **panel counting loops**, which kept
comparing `r.size contains sz.csv` against the raw string — the same accident, one level up,
surviving the fix that was supposed to end it. Both now split first. The lesson is that
"correct by accident" tends to exist in more than one place: the grep worth running is for
`contains sz.csv`, not for the one line someone happened to notice.

**A panel's own visibility and a row's size gating were two separate mechanisms**
(need/sector/region for the panel, `size` for the `<li>`s inside it) — which meant nothing
stopped a CSV edit from restricting every row in a panel to sizes that don't add up to
"everyone", leaving the panel rendered, heading and all, with an empty body for whichever
size that left out. This was flagged as a latent risk before it was a real one — every
panel had at least one row visible at every size, at the time `test_no_panel_ever_renders_with_zero_visible_programs`
was written to guard it — until gating the Atlantic RTRI row to `1to5m;5mplus;large;nonprofit`
(its own eligibility requires $1M+ annual revenue; see the CSV `note`) made it the *only*
row in the Atlantic + liquidity/transformation regional group, and `size-under1m` had
nothing left to show.

The regional-programs panel now generates one reveal rule per **need × region × size**
that actually has a qualifying row, not just need × region — the same
generated-CSS-per-marker pattern used everywhere else, extended by one dimension:

```css
#wz-state.need-liq.reg-atl.size-1to5m .wz-rg-reg-atl-liquidity { display: block; }
```

For `size-under1m`, no such rule exists at all, so the panel stays hidden — not rendered
empty. Computing "does this size have a qualifying row" couldn't reuse `where_exp` with a
literal `== nil` / `== ""` comparison the way the rest of this file does: under real
template rendering (not an isolated test), `where_exp`'s reused-template-plus-`context.stack`
mechanism gave wrong answers for that specific comparison, even though the identical
comparison was reliable everywhere else `where_exp` is already used (e.g. `r.need contains
ncsv`) and in isolated tests of the same expression. The count is a plain nested
`{% for %}` / `{% if %}` loop instead — slower to read, but it doesn't touch the part of
Liquid that misbehaved.

**The sector cell now has the same fix, and getting it was not optional.** The paragraph
above used to end by calling the other three panel types a theoretical gap "not yet needed
by anything in the CSV." Gating BDC's Steel and Aluminium Industries Support Program to
$1M+ needed it within the hour: that program is the only row in the steel liquidity cell,
so `size-under1m` had a heading over an empty list in seven regions at once.
`test_no_panel_ever_renders_with_zero_visible_programs` caught it exactly as that paragraph
promised, in both languages, before anything shipped.

The sector-cell rule is now generated per **need × sector × size**, the same shape as the
regional one:

```css
#wz-state.need-liq.sec-steel.size-1to5m .wz-p-liquidity-steel-and-aluminum { display: block; }
```

**Two panel types are still unfixed: the sector-agnostic column and the hubs.** They are
genuinely un-emptied today — every row in them is either ungated or sits beside an ungated
sibling — but "not needed yet" is exactly what was said about the sector cell. The guard
test covers all four, so the failure mode is a loud test, not a broken page. If you are
gating the last remaining row in either, expect to generalize the pattern one more time.

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

"Other" (`sec-mfg`) is deliberately absent from `sectors:` — it has no sector-specific
stream, so it stamps a marker no generated rule names and the visitor drops through to the
sector-agnostic column, their region and the hubs. It is the *only* Q4 answer like that,
which makes it the one to reach for when a test needs a sector that reveals no sector
panel; `test_letl_only_shows_for_size_large` and
`test_steel_support_requires_at_least_1m_revenue` both do exactly that.

**Absent from `sectors:` is the mechanism, not an oversight.** Adding `sec-mfg` to that
bridge would point it at a CSV sector and silently turn the catch-all into a fourth
sector. The marker name still says `mfg` because renaming it would touch both YAML files,
four `clears:` cascades and two tests to no visible effect — the label is what a visitor
reads, and the label is "Other".

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
- **Back destroys the results, so results open in a new tab.** fieldflow keeps its state in
  the DOM, not in the URL — there is no query string to return to. A usability participant
  opened a program, pressed Back, and landed on an empty wizard with four answers to give
  again. Every link that leaves for a program now carries
  `target="_blank" rel="noopener noreferrer"`, a `.wz-ext` arrow, and a `wb-inv` sentence
  saying so; a new tab that opens silently fails WCAG 3.2.5, so the three travel together.
  The arrow and the sentence sit *inside* the `<a>`, which means anything reading a link's
  text has to strip them first — `Wizard.link_text` is that, and forgetting it makes every
  program name comparison fail at once. "Start over" is the exception: it goes back to this
  same wizard, so it stays in the tab it is in.
- **This file is excluded from the build, and has to stay excluded.** Jekyll runs Liquid
  over the folder's renderable files before Markdown ever sees them, and a fenced code
  block protects nothing — Liquid parses the whole file first. This document quotes the
  template's own tags, so one `{% for %}` written to be read rather than run failed to
  parse, took the entire Pages build down with `Syntax Error in 'for loop'`, and stranded
  test.canada.ca on a stale build for five hours. One broken file fails the *site*, not
  just the page. `_config.yml` lists it under `exclude`, and
  `test_every_file_the_build_reads_parses_as_liquid` is the guard: every `.html`/`.md` in
  this folder either parses as Liquid or is excluded. **If you add a document that quotes
  Liquid, exclude it in `_config.yml` in the same commit** — or wrap the examples in
  `{% raw %}`, which is the alternative the exclusion was chosen over, since this file was
  never meant to publish anyway. Note that `exclude` *replaces* Jekyll's defaults rather
  than adding to them, so the list restates them; drop one and it starts publishing.

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

- **All 1,008 combinations** (168 need x region x sector, crossed with every size answer),
  both languages. It parses the generated CSS back out of the
  page, works out which panels a set of answer markers reveals, and diffs the programs
  in them against the CSV — which it reads through a second, separate implementation of
  the rules on this page, so it cannot just agree with the template's bugs.
- **The CSV**: required columns, closed vocabularies for need / sector / region / status,
  https URLs, French coverage on every row that renders, no untriaged duplicate
  destinations.
- **RDA link**: exactly one — the right one — for whichever region was chosen, sitting
  directly above "Start over", and that the removed eligibility criteria section stays
  fully gone rather than just unreachable.
- **Markup**: one h1 and no skipped heading levels, the fieldflow chain, the reset
  cascade, and each gotcha listed above — `.hidden` on a generated-rule target, the wrong
  `wet-*.js`, the missing space before a French colon, missing `layout: null`.
- **Parity**: the French templates are the English ones with the language swapped, and
  the two YAML files stay the same shape.
- **Standalone, and the build**: `data_dir` still points into this folder, the pages
  render populated rather than merely well-formed, and — the guard added after the
  five-hour outage — every `.html`/`.md` here either parses as Liquid or is excluded in
  `_config.yml`.

Five tests pin decisions rather than data — the forestry transformation cell routing to
NRCan and not BDC, the duplicate-URL triage, BDC's product being the "Pivot to Grow
Loan" rather than the deck's bare "Pivot to Grow", and the Business Benefits Finder
being the one promoted `need: featured` row with no size gate. Data-driven tests cannot catch those:
both sides read the same CSV, so changing the CSV changes the expectation too. If one of
those decisions is genuinely revisited, delete the test on purpose.

## Verifying a change

Run the suite. What is left needs a browser, because wb-fieldflow builds the radios,
fieldsets and legends at runtime — before init there is nothing in the static HTML to
find.

Do **not** click through every combination: fieldflow re-renders on each answer and a
backgrounded Chrome tab throttles timers hard enough that a click-driven sweep takes
minutes and produces confusing intermediate states. The suite already covers all 1,008.

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
  The split is at Muskoka. The Northern answer names Parry Sound explicitly, since that's
  the district people are most likely to be unsure about; the Southern answer originally
  spelled out "(south of Muskoka)" too, but was simplified to "Southern and Eastern
  Ontario" — plain enough that someone in Ottawa or Kingston doesn't read "Southern" and
  assume it means someone else.
- **Results end with a link to the business's own RDA**, just above "Start over." Not the
  region's tariff-specific program — that's already linked above, under "Programs for your
  region" — but the agency's own homepage, there because the RDA is worth pointing to
  regardless of what the CSV's programs turn up for that need. It's not deck content:
  `regions:` in each YAML carries `rda` and `rda_url` fields alongside the marker and `csv`
  value, names taken from each page's own `<h1>`, all seven URLs checked live on
  2026-09-03. The paragraph for every region is in the DOM at once, one
  `#wz-state.reg-marker .wz-rda-reg-marker` rule each, same pattern as the sector hubs'
  `.wz-hub-*` rule above it. It originally sat inside the eligibility criteria section —
  see the removal entry below for why it moved.
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
  direction. It sits right after "Under $1 million." At the time this was added, size only
  changed the (since-removed) eligibility badges, never which programs showed — the next
  entry is why that's no longer true.
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
  "non-profits," would otherwise be indistinguishable to the routing mechanism. Pinned by
  `test_agrimarketing_sme_and_nia_are_mutually_exclusive`.
- **The eligibility criteria checklist is gone.** The badge grid — Canadian-incorporated,
  years operating, revenue, cash flow, U.S.-export share, each with a Met/Not
  met/Needs review badge — read as confusing next to the results rather than helpful, so
  the whole section was removed: `eligibility` and `eligibility_rules` are gone from both
  YAML files, and `.wz-badge` / `.wz-met` / `.wz-notmet` / `.wz-review` / `.wz-crit` /
  `.wz-rb` and their generated CSS loop are gone from both templates.
  `size-nonprofit`'s eligibility-badge placeholder decision (the previous two entries)
  is moot now that there's no badge UI left — its `size` column routing (LETL,
  AgriMarketing/NIA) is a separate mechanism and is unaffected.
- **"Where is your business mainly located?"**, not just "located" — a business with sites
  in more than one region needs a single answer to give. "Headquartered" was tried first
  and reverted: precise, but corporate-sounding language a small business owner might not
  immediately map to themselves. "Mainly located" resolves the same ambiguity in plainer
  words.
- **The CDTS "Share this page" widget is off, on all four pages.** `wet.builder.preFooter`
  defaults to showing it — passing `"showShare": false` is what turns it off; there's no
  markup of our own to remove; the widget didn't exist in this repo's source at all before
  WET's own JS built it in as a default.
- **Atlantic's RTRI row is now gated to ACOA's own eligibility.** ACOA's SME stream
  requires the business to have been viable before the tariffs and to have $1M+ in annual
  revenue — `size` is `1to5m;5mplus;large;nonprofit` (everyone except `under-1m`). The
  "viable before tariffs" test and the 25%-US/China-sales-or-tariff-affected test aren't
  gated: the first has no wizard answer to hang it on, and the second's OR-branch
  ("affected by trade disruptions") is true for literally every visitor this tool has,
  by definition — see the row's `note`. This is the row that forced "How a size-gated row
  hides itself" above to get a real fix rather than stay a documented risk: it's the only
  program in Atlantic's regional group, so `size-under1m` had nothing left to show once it
  was gated, and the panel would have rendered empty rather than not rendering at all.
- **RTRI's eligibility is set per RDA, and six of seven gate on $1 million.** The deck
  treated the Regional Tariff Response Initiative as one program with one set of rules. It
  isn't: each RDA publishes its own eligibility, and all seven were checked one page at a
  time. ACOA, FedDev, FedNor, PrairiesCan, PacifiCan and CanNor all require $1M+ in annual
  revenue — the `size` column expresses that exactly, since `size-under1m` is the only Q3
  answer below the line, so all six carry `1to5m;5mplus;large;nonprofit`. One does not fit:

  **CED (Quebec) requires $2M+, fewer than 500 employees, and manufacturing.** None of the
  three is expressible. $2M falls *inside* the "$1 million to $5 million" answer, so no size
  gate can separate a qualifying $3M business from a non-qualifying $1.2M one; "fewer than
  500 employees" is a ceiling where every other gate is a floor; and manufacturing is a Q4
  answer with no sector routing behind it. Left ungated on purpose — see the row's `note`,
  and "Q3's buckets are not being redrawn for one region" below.

  **The national hub row is deleted.** RTRI used to have an eighth row — the ISED hub
  covering every region — which surfaced under "open to all sectors" while the visitor's own
  RDA row sat in "Programs for your region" directly below. Two entries for the same
  programme, the general one above the specific one. It was briefly size-gated to match the
  regions instead of removed; that was the wrong fix, because the hub is redundant whenever
  it appears rather than only at some sizes. Checked exhaustively before deleting: across all
  70 need × region × size combinations the hub could render in, there is **not one** where it
  is the only RTRI result. Every region has its own row, both cover the same two needs, and a
  region answer is mandatory — so the specific row is always there. A business that wants the
  national picture still gets its own RDA through the `rda_url` link at the foot of results.

  **`nonprofit` is in all seven gates because the floor is an *SME* criterion.** RTRI
  describes itself as equipping "SMEs, and the organizations that support them" — two
  populations, not one — and every revenue floor that names a subject names an SME ("SMEs
  must have… at least $1 million"). A board of trade is therefore not a small SME failing a
  $1M test; it is in the other population, which has no stated floor. That is reasoning from
  the hub's wording plus the three pages that give a subject, not a quoted non-profit rule:
  four RDA pages were read only for their revenue fragment. The canonical write-up moved to
  the **Atlantic** row's `note` when the hub row was deleted — the reasoning was derived
  there originally, and the other six point at it.

  **Read the alert banner, not just the eligibility list.** FedNor appeared during this
  sweep to be a second exception with no floor at all, and an argument was half-built for
  why that might be deliberate. It states the $1M floor in an alert banner at the top of the
  page instead of in the eligibility section below. The general lesson is worth more than
  the specific fix: these seven pages do not share a template, so a criterion absent from
  where the last six pages put it is a reason to re-read the whole page, not a finding.
- **Q3's buckets are not being redrawn, and two thresholds now straddle them.** The real
  thresholds in the CSV are $1M, $2M (CED), $10M (EDC direct lending) and $150M (LETL). The
  buckets were drawn before any of them were known, and two now cut through the middle of a
  bucket rather than along its edge:
  - **CED's $2M** sits inside "$1 million to $5 million" — a $1.2M and a $3M business give
    the same answer, and only one qualifies.
  - **EDC's $10M** sits inside "$5 million or more" — so that row is gated `5mplus;large`,
    which correctly excludes everyone under $5M but still shows the program to a $5–10M
    business who cannot use it.

  Drawing buckets that fit every threshold would need roughly six size answers before the
  non-profit one, turning the shortest question in the wizard into its longest. And it still
  would not capture CED's other two tests (<500 employees, manufacturing) or EDC's "seeking
  at least $1M in funding", none of which are sizes at all. The size gate is therefore doing
  what it is good at — excluding whole buckets that are certainly ineligible — and the
  residue belongs in **criteria text on the result card**, a mechanism the CSV does not have
  yet. That mechanism is now wanted by at least two rows rather than one, which is what
  makes it worth building rather than deferring again.
- **Q4's U.S.-exporter answer is gone.** "Exporting to the U.S. with 15% or more of revenue
  from U.S. exports" was the odd one out in a question whose other four answers are sectors,
  and it asked the visitor to self-assess a percentage — the same exposure threshold the DM
  ruled out as a triage question, since BDC uses 15% and RTRI 25%. Removed on direction.
  **It drove no logic:** like manufacturing, it was absent from the `sectors:` bridge, so the
  `sec-usexport` marker it stamped matched no generated rule and anyone choosing it saw
  exactly the sector-agnostic results. Removing it therefore changes no routing — only the
  question. What it did touch was bookkeeping: the marker appeared in all four `clears:`
  cascades in both YAML files, and two tests used `sec-usexport` as their "sector that
  reveals no panel" (now `sec-mfg`, the only remaining answer of that kind). The sweep is
  driven off Q4's own options, so it dropped from 700 combinations to 560 by itself — the
  count is restated in four places, all updated. Incidentally this made the "twenty markers"
  figure in "How a combination becomes a visible panel" true again; it had been 21.
- **A second remission process, and both remission labels stop repeating themselves.** The
  steel derivative goods remission (Finance Canada) is new: open to any firm incorporated
  in Canada, no size or sector test on the page, so `size` is blank and it is
  sector-agnostic — "steel derivative goods" describes what is imported, not who imports
  it, and the importers are manufacturers across sectors rather than steel producers. It
  routes to `liquidity;transformation`, and the general U.S.-goods remission was moved to
  match: the two are the same mechanism on different goods, and answering different needs
  implied a distinction the department does not draw. Liquidity is named first in both, so
  both file under it in the all-view.

  The labels are the reason this is written down. The two pages' h1s share their first
  eleven words — "Process for requesting remission of tariffs that apply on certain…" —
  which as two links one above the other is unreadable, and a screen reader says the whole
  stem twice before reaching the difference. Both rows are now composed rather than taken
  verbatim: **"Tariff remission: goods from the U.S."** and **"Tariff remission: steel
  derivative goods"**, with the French matched. That is a deliberate departure from the
  default of naming a program by its own h1, so `fr_source` on both rows records the h1 it
  came from and why it was front-loaded. The h1s were checked live the day of the change
  and were unchanged; only the rendered label is ours.
- **French review from DEC/CED, applied and rationalized against what had changed since.**
  Samir Goulamaly (DEC/CED, the Quebec RDA) reviewed the French wizard in tracked changes.
  Marked directly: "nous vous **montrerons**" became "nous vous **indiquerons**"; the
  intro's repeated "à" was dropped ("à votre besoin, votre région, votre taille"); "votre
  secteur" became "votre **secteur d'activités**"; and two Q1 answers were rewritten to
  actually answer the question they sit under — "De quoi avez-vous besoin?" takes the
  partitive, so "Un projet" became "**D'un** projet" and "Le maintien en poste et le
  recyclage de votre main-d'œuvre" became "**De maintenir votre main-d'œuvre en poste et
  d'en assurer la reconversion**". That pattern is now the rule for Q1 in French: du, des,
  d'un, de.

  The review was done against an older page, so three consequences were carried across
  rather than left inconsistent. The `needs:` heading for workforce still said "recyclage",
  the word the reviewer had just replaced — it is "reconversion" now, and `recyclage`
  appears nowhere in the French file. "Tout ce qui précède" postdates the review and is the
  fifth answer to the same question, so it takes the partitive too: "**De** tout ce qui
  précède". And the start page describes the same four questions, so its "votre secteur"
  became "votre secteur d'activités" as well. None of these three were marked by the
  reviewer; they follow from what was.

  This is the first place the two languages deliberately diverge in register. English Q1
  answers are noun phrases under "What do you need right now?"; French ones are now verb
  and partitive phrases under "De quoi avez-vous besoin?". Both are right for their own
  question, and the parity test only flags strings that are byte-identical, so nothing here
  fights it.

  **Revenue is `chiffre d'affaires` in French, not `revenus`.** The reviewer struck "vos
  revenus" for "votre chiffre d'affaire" in the Q3 legend, which settles a collision his
  screenshots could not have seen: the legend and the first answer had both moved to
  "revenus annuels" the same week. The word now appears once, in the first answer, and not
  again — the rule the English answers already followed, and the reason his own addition of
  "de chiffre d'affaires" to the $5M answer was not kept. `revenus` is gone from the French
  file. Also from the same pass: "5 millions de dollars ou plus" became "**Plus de** 5
  millions", which quietly fixes a real overlap — "De 1 à 5 millions" and "5 millions ou
  plus" both contain exactly $5M, and **the English still does**; "Plus grande entreprise"
  became "Grande entreprise", since the $150M figure and not the comparative is what does
  the work; and Q4's legend gained "d'activités".

  **What was declined, so it is not re-litigated.** Three comments came back with the
  edits. One asked what separates the financing answer from the transformation one — that
  is a question about the wizard's structure, not its French, and liquidity and
  transformation stay separate answers: decided above this review and confirmed in
  usability testing. One asked for a verb in "D'un projet de transformation ou
  d'immobilisations", which contradicts the tracked change a second reviewer had just made
  on that same line; the tracked change won. The remaining two were the reviewer's own
  rationale for edits already applied. One tracked change was also left out: rewriting the
  non-profit answer as "Pas de chiffre d'affaires (organisme sans but lucratif...)" answers
  the revenue question the current wording ignores, but "no revenue" is not true of most
  non-profits and it would diverge from the English. Open, not rejected.
- **Question 4 asks for the sector, and only that.** The legend still read "What is your
  sector and tariff impact?" after the U.S.-exporter answer was removed — the tariff-impact
  half had nothing left to point at, and the question had been asking two things anyway. It
  is now "What is your sector?" ("Quel est votre secteur?"). "Other manufacturing and
  exporters" also moved from third to last: it is the one answer with no stream of its own,
  so it belongs at the end reading as the catch-all it is, not sitting between steel and
  agriculture as though it were a fourth sector with its own programs. Answer order is
  presentation only — the routing sweep iterates the options and does not care what order
  they come in.
- **Results open in a new tab, after a usability session cost someone their answers.** The
  participant clicked a program, read it, pressed Back — and had to answer all four
  questions again, because fieldflow's state lives in the DOM and Back rebuilt the page
  empty. Keeping the state in the URL is the fuller fix and a much larger change; opening
  results in a new tab is the one that could ship the same day. All ten anchors that leave
  for a program — the eight program lists, the featured Business Benefits Finder line and
  the RDA line — now carry `target="_blank" rel="noopener noreferrer"` plus an arrow and an
  invisible sentence, captured once at the top of the template as `NEWTAB` rather than
  written out ten times. The wording and the arrow copy the GC Design System's `gcds-link`,
  which the department's other tools already use, so the two read the same way; canada-
  strong is a CDTS/WET page and cannot load GCDS components, so the markup is reproduced
  rather than imported. "Start over" is deliberately left alone.
- **Work-Sharing is a prerequisite for the Worker Retention Grant, and the column now says
  so.** The dependency was research the CSV already held — the grant's `note` has always
  read "Requires an approved Work-Sharing agreement" — but nothing reached the page: the
  two sat three apart in the workforce column, in an order that put the grant first, with
  no hint that one gates the other. The grant's rendered name is now "Worker Retention
  Grant (prerequisite: Work-Sharing Program)", matched in French with "(préalable :
  Programme de Travail partagé)", and the two rows were swapped so the prerequisite is
  listed above the thing that needs it. Row order in the CSV is the display order within a
  panel, so this was a CSV edit and nothing else. `fr_source` on that row now records that
  the bracketed half is composed rather than taken from the page's `h1`, which is what that
  column is for.
- **Question 3 asks one thing, and its answers answer it.** The legend was "What is your
  size and revenue?", which asked two questions and let the answers drift into criteria
  again — `size-5mplus` read "$5 million or more with 10 or more full-time employees",
  reintroducing exactly the mistake the "3 or more years operating" trim below had already
  corrected on the answer beside it. A headcount is not a revenue band, and no CSV row
  routes on it. The legend is now "What is your annual revenue?", `size-5mplus` is "$5
  million or more", and "Larger enterprise ($150 million or more in annual revenue)" drops
  its last three words, which the question now supplies. The `$150 million` number stays —
  that one is doing real work, per the entry below. Nothing about the routing changed:
  these are labels, and the `sizes:` vocabulary bridge and every `size` cell in the CSV are
  untouched.
- **Question 1 gained "All of the above".** Departments were not the only ones reading the
  wizard as a complete list; a business that wants everything it qualifies for had no way
  to ask for it, and four separate runs of the wizard was the only workaround. The answer
  shows every program for the sector, region and size at once — 29 of them for an Atlantic
  agriculture SME, against 9 for financing alone — still grouped by need. It is not a
  fifth need: see ""All of the above" is a second set of panels" above for why it needs
  its own panels and what that does to the meaning of a semicolon-separated `need` cell.
  The sweep grew from 560 combinations to 700 by itself, being driven off Q1's own
  options. One latent bug surfaced while wiring it up:
  `test_no_sector_panel_when_the_cell_is_empty` matched panel classes by substring, and
  `wz-p-financing-` is a prefix of `wz-p-financing-agnostic` — so the sector-agnostic
  column was being counted as a sector panel and the manufacturing answer passed for the
  wrong reason. It matches whole class names now.
- **The hub panel points outward now: "More options".** It was headed "Where these programs
  are listed" and explained that the hubs were the departments' own current lists. That
  framing invited the reading that the wizard's four answers *were* the tariff programs, and
  departments were making it. The panel is now headed **More options**, introduces its links
  with "For more programs and context:", and closes with a sentence promoting the **Business
  Benefits Finder** — "view or search all provincial and federal programs and services,
  including tariff support". The Finder was already a hub row; it is now the CSV's one
  `need: featured` row, which takes it out of the hub list and gives it its own line. `need:
  featured` matches no question answer and carries no `size`, so it renders on all 1,008
  combinations — that is the point, and `test_exactly_one_featured_row_and_it_is_the_benefits_finder`
  pins it. Its URLs changed too, from the Finder's front door to the tariff-filtered
  `list-liste` view with ISED's token, so the link lands on programs rather than an empty
  search. The line is a `<p>`, not a list item, so the routing sweep cannot see it;
  `test_the_featured_finder_line_closes_the_hub_panel_*` checks it instead.
- **Results lead with the region, not the national column.** The panel order is
  sector-specific cell → **Programs for your region** → *need*: open to all sectors →
  departmental hubs, i.e. most specific first. It used to put the national column above the
  regional one, which read oddly: the visitor answered a region question, then had the
  answer to it shown third. The two blocks were swapped in both templates; nothing else
  about them changed, and the generated CSS is unaffected since each panel is revealed by
  its own rule regardless of document order.
- **The "Regional criteria and intake dates vary" footnote is gone.** It sat under the
  regional list, hedging in the abstract about criteria the tool now encodes concretely —
  seven RDA eligibility rules, six of them size-gated. `region_footnote` is removed from
  both YAML files and the `<p>` from both templates.
- **In agriculture the `size` column is carrying organization type, not size at all.** Most
  agriculture programs have no revenue threshold, so their blank `size` is verified rather
  than unchecked. What does vary is *who* qualifies, and the only lever for that is
  `size-nonprofit` — the one Q3 answer that is a kind of organization rather than a
  turnover band. So:
  - **AgriStability and AgriInvest are farmers-only**, and now carry
    `under-1m;1to5m;5mplus;large` — every business size, no non-profits.
  - **Price Pooling goes the other way and must stay blank.** It is open to associations of
    producers *and* to processors and marketing agencies, so it is not the AgriMarketing NIA
    case ("associations only") and must not be gated to match it. Its real test — marketing
    under an official cooperative plan and pooling revenues — is not a size at all, so blank
    over-shows it to ordinary farm businesses. Criteria text, not a size gate.

  AgriInvest and Price Pooling arrived on the same deck slide, in the same box, and point in
  opposite directions on exactly this question. Splitting that box into two rows was already
  recorded as a correction; it turns out to have mattered more than it looked.

  FCC's Trade Disruption Customer Support Program was checked and has no size criteria, so
  its blank is verified too. That leaves the **Advance Payments Program** as the last row in
  this cell whose eligibility has not been read off its own page — it advances against a
  producer's own crop or livestock, so farmers-only is the likely answer, but that is an
  inference and its `note` says so rather than acting on it.
- **BDC's two loans are gated differently, and that difference carries weight.** The Pivot
  to Grow Loan requires $1M+ annual revenue, so it is gated like the RTRI rows
  (`1to5m;5mplus;large;nonprofit`). Its other three criteria — 3 years in business,
  historically positive cash flow, and 15% of sales exported to the U.S. — are not gated: no
  Q3 answer fits the first two, and the third is the exposure threshold that was ruled out
  as a triage question in the first place, BDC's 15% against RTRI's 25% being exactly why
  this tool triages by size. BDC's **Equipment Loan** has no revenue floor at all (Canada-
  based, 12+ months generating revenue, profitable, good credit), so its blank `size` is
  verified rather than unchecked, and it should stay blank: it is what an under-$1M business
  still sees under financing once Pivot to Grow is gated away from them. Gating the two to
  match would leave the smallest businesses with materially less than they qualify for.
- **The product is the "Pivot to Grow Loan"; the deck's "Pivot to Grow" survives only in
  `slide_label`.** Both strings sit in the same row, one rendered and one not, which makes
  promoting the wrong one an easy future slip. `test_pivot_to_grow_is_named_in_full` pins
  the rendered name in both languages *and* asserts the bare form appears nowhere in the
  page body, so `slide_label` can keep doing its archival job without the short name being
  one careless edit away from a user.
- **A program serving two needs is one row, not two.** The deck listed BDC's Pivot to Grow
  Loan under both financing and liquidity, and the RTRI national hub (since deleted) under both liquidity
  and transformation, so the CSV carried each twice — the second copy flagged
  `duplicate-url`, sending a second, differently-named result to a page already linked
  above. The `need` column has always taken semicolons (the seven regional RTRI rows use
  `liquidity;transformation`), so both are now single rows with `need` listing both needs.
  This also retired the composed name "Pivot to Grow Loan - Liquidity Support stream": BDC's
  one page covers three streams and has no anchor to deep-link, so naming a stream the page
  does not separately title was inventing a program. Two of the three `duplicate-url` rows
  are gone as a result.
- **Question 3's two largest answers were trimmed, renamed, and given a real number.**
  "$1 million to $5 million" no longer says "and 3 or more years operating" — a criterion,
  not a size, and this question is about size. "Large enterprise" became "Larger enterprise
  ($150 million or more in annual revenue)": LETL's real eligibility (colleague-verified,
  not in the original deck) needs roughly $150M or more in annual Canadian revenue and a
  minimum loan size of $60M — well above what a business would guess "large" means on its
  own, and well above `size-5mplus`'s $5M+ floor. Putting the number in the answer itself,
  not just the word "Larger", is what actually stops a $10M-$50M business from
  self-selecting into a bucket that only shows them a $60M-minimum loan they can't use —
  the size logic already routed them correctly (`size-5mplus`, not `size-large`) before
  this, the ambiguity was in the label a person reads, not the routing. See LETL's `note`
  for the full criteria.

- **The data files were matched back to the launched page (2026-09-10).** The tool
  shipped as hand-maintained raw HTML rather than from this build, so the live page
  became the source of truth for content while this folder kept the model. Matching one
  to the other is a structural diff, not a read-through: render `_tests/preview.rb`
  output, pull every panel down to `(panel id, program name, URL, org)` on both sides,
  and diff those. Doing it by eye would have buried the four real changes under ~200
  differences of markup convention — live rewrote the reveal mechanism (Bootstrap
  `.hidden` plus fieldflow `removeClass` actions, panel `id`s instead of generated CSS
  and `wz-` classes), writes canada.ca links root-relative, and renamed the org span to
  `.text-muted`. None of that is content. What was:
  - **The Strategic Response Fund now answers liquidity as well as transformation**, and
    both URLs deep-link the tariff-relief section of its key investment priorities rather
    than the programme front door. `liquidity` is named first, so the all-view files it
    under Liquidity.
  - **Finance Canada is now `FIN`**, the only org that had been written as a name rather
    than an acronym.
  - **English answer labels** took Canadian Press province abbreviations (`N.B.`,
    `Man.`, `N.W.T.`), dropped the repeated "in annual revenue" the Q3 legend already
    supplies, and changed "exporters" to "exporting". Q2 became "primarily located" —
    which reverses the "mainly located" entry above, and incidentally brings English in
    line with the French, which had always said "principalement".
  - **French answer labels** were taken verbatim from live, including Q1 losing the
    partitive. See the two flags below.

  **`org_fr` is new, and the launch is what exposed the need for it.** One `org` column
  served both languages, so the French page credited AAFC, NRCan, CBSA, GAC, ESDC, ACOA,
  FCC and ISED with their English acronyms. Live fixed that by hand; the model could not
  express it. `org_fr` is the French twin, same blank-falls-back contract as `name_fr`,
  read through an `ORGF` indirection beside `NAME` and `URLF` at the top of each
  template. 28 of 57 rows carry one. `test_org_fr_is_set_consistently_for_every_org`
  guards the failure the fallback invites — one row filled in and its twin left blank,
  which renders as the same department credited two ways on one page.

  **Two things were deliberately not matched, and both are arguments for the model.**
  - **The French sector-agnostic heading is inconsistent on the live page.** It reads
    "tous les secteurs" under financing and liquidity, and still "tous secteurs
    confondus" under transformation and workforce. In this folder that string is one
    key, `labels.agnostic_suffix`, so the inconsistency is not reproducible — it is
    "tous les secteurs" in all four. This is the clearest thing the launch demonstrated:
    the edit was made twice by hand where four occurrences existed, and nothing caught it.
  - **Three abbreviations were wrong, two in French and one in English**, and all three
    are corrected here rather than matched. In French, `Î- P.-É` (stray space, no period
    after `Î`, no final period) is now `Î.-P.-É.`, and `T.N.-O` is now `T.N.-O.`; `Nt`
    and `Yn` were already the TERMIUM forms and stay. In English, `The North (NU, N.W.T.,
    Yk.)` ran three conventions through three items — `NU` is a postal code, `N.W.T.` is
    Canadian Press, and `Yk.` is neither (the postal code is `YT`, and CP spells Yukon
    out; it looks worked backwards from the French `Yn`). It is now **`The North
    (Nunavut, N.W.T., Yukon)`**, which is what CP does with the two territories that have
    no settled short form.

    The rest of the region labels were checked at the same time and are right as they
    stand: `Man., Sask., Alta.` and `N.B., N.S., P.E.I., N.L.` are correct CP, and
    `Man., Sask., Alb.` and `N.-B., N.-É., Î.-P.-É., T.-N.-L.` are correct TERMIUM.
    Postal codes (`AB`, `SK`, `MB`) are a different register — addresses and tables, not
    answer labels — so the pre-launch labels, which used them throughout, were the thing
    that was actually off-style. Both languages now use the abbreviation where the style
    guide has one and the full name where it does not, which is the rule that makes the
    English and French lines agree convention-for-convention rather than word-for-word.

  **What the match cost the French review.** The live Q1 answers are noun phrases again
  — "Financement…", "Liquidités…", "Projet de…", "Rétention ou requalifications de la
  main-d'œuvre", "Tout ce qui précède" — which undoes the tracked changes Samir Goulamaly
  (DEC/CED) made, recorded in the French-review entry above. They no longer answer the
  partitive question they sit under ("De quoi avez-vous besoin?"), and "requalifications"
  is a third word for the thing he had already moved from "recyclage" to "reconversion".
  Taken verbatim on direction, so the page and the data agree; the `needs:` heading for
  workforce still said "reconversion", which was then the one place that wording survived
  — until retraining moved to the hiring answer on 2026-09-11 and took the last of it
  with it. If the review is ever reinstated, that entry has the reasoning and this one
  has what replaced it.

- **The SRF row is named for the Canada Strong Diversification Fund, not its parent.**
  The row renders as **"Canada Strong Diversification Fund (Strategic Response Fund)"** /
  **"Fonds de diversification pour un Canada fort (Fonds de réponse stratégique)"**, and
  links to the CSDF eligibility and expression-of-interest page. It was briefly left as
  plain "Strategic Response Fund (SRF)" when the department asked for a link change only;
  reading the SRF's own pages is what changed that.

  **The SRF has three key investment priorities, and only one of them is ours** — Tariff
  relief (the CSDF), Innovation, and the AI Compute Challenge. Naming the row after the
  parent fund therefore pointed a tariff-affected visitor at something two-thirds
  irrelevant to them, while linking to the tariff page anyway. The parent stays in
  brackets because departmental news releases name the SRF, so someone searching that term
  still finds the row.

  **It is still one row.** There is no second thing to apply to: the CSDF is "delivered
  through the Strategic Response Fund", with one SRF-level eligibility tool behind it. A
  firm could pursue a tariff project and an innovation project, but it would do that by
  choosing a Pillar in one application, not by picking between two funds.

  **Mind the vocabulary if you go back to these pages — three axes, three words, and they
  do not line up.** The eligibility tool divides the SRF into two **pillars** (Business
  Innovation/Investment Attraction/Growth; Innovation Ecosystems). The priorities page
  divides it into three **priorities** (the list above). The CSDF page divides *itself*
  into two **streams** (adapting/pivoting/diversifying; capital maintenance). "Stream" is
  the bottom layer; the CSDF sits at the middle one. Reading any one page alone makes the
  other two layers invisible, which is how the row came to be named after the parent in
  the first place.

  **The $20M size gate is a proxy, and is knowingly left as one.** The CSDF page says it
  "focuses primarily on proposals with eligible project costs of more than $20 million and
  requests for federal contributions of $10 million or more" — that is **project cost**,
  where Q3 asks **annual revenue**. A firm bringing a $20M project is rarely small, so the
  gate is defensible, but it is not the stated criterion and should not be read as a
  verified threshold. Raised with ISED on 2026-09-10; left in place pending their answer,
  and a third candidate for the per-row criteria line in "Next steps".

- **Q3 gained a sixth answer, and it exists for exactly one row.** "$5 million or more"
  was split into **"$5 to $20 million"** and a new **"$20 million or more"**
  (`size-20mplus`), placed before "Larger enterprise". The new band inherits everything
  the old top band showed — all thirteen rows carrying `5mplus` are revenue *floors*, so
  a $20M business qualifies for every one of them, and each gained `20mplus` alongside.
  `test_the_20m_band_differs_from_5m_only_by_srf` pins that: across all 140 need × region
  × sector combinations, the only program that differs between the two answers is SRF.

  **SRF-CSDF is the row the band was added for.** It is now `size: 20mplus;large`, so it
  shows only at the top two answers, and its existing `liquidity;transformation` need cell
  already restricts it to Liquidity, Transformation and "All of the above" — no need
  change was required. That works out to 6 need × size pairs × 7 regions × 4 sectors =
  **168 of the 1,008 combinations**, and `test_srf_shows_only_at_20m_plus_and_large` checks
  both halves: nothing outside those 168, and nothing missing inside them. This is a
  decision test, not a data test — both sides would otherwise read the same CSV.

  **The sweep is now 840 combinations**, up from 700, because it is driven off Q3's own
  options. The count is restated in four places, all updated, and "twenty-one markers"
  became twenty-two.

  **Two thresholds still straddle a bucket, and one of them is new.** The entry above
  ("Q3's buckets are not being redrawn") listed CED's $2M and EDC's $10M as thresholds
  cutting through the middle of an answer rather than along its edge. The new split does
  not fix either — **EDC's $10M now sits inside "$5 to $20 million"** instead of inside
  "$5 million or more", which is the same problem one bucket narrower, and CED's $2M is
  untouched inside "$1 million to $5 million". The per-row criteria line in "Next steps"
  is still where that residue belongs.

  **The English boundary labels were rewritten to match the French, not the other way
  round.** As first drafted they were "$5 to $20 million" and "$20 million or more",
  which disagreed with the French at the $20M boundary — "Plus de 20 millions" excludes a
  business at exactly $20M, "or more" includes it — and dropped the unit off the first
  figure, which the French carries on both. They are now **"$5 million to $20 million"**
  and **"More than $20 million"**, so each band means the same thing in both languages:

  | | English | French |
  |---|---|---|
  | | Under $1 million | Moins de 1 million de dollars |
  | | $1 million to $5 million | De 1 à 5 millions de dollars |
  | | $5 million to $20 million | De 5 à 20 millions de dollars |
  | | More than $20 million | Plus de 20 millions de dollars |
  | | Larger enterprise ($150 million or more) | Grande entreprise (150 millions de dollars ou plus) |

  The French is the reference here because the DEC/CED reviewer had already settled this
  question once on that side, changing "5 millions de dollars ou plus" to "Plus de 5
  millions" so two adjacent bands would not both name the same figure — see the
  French-review entry above. Applying his convention to English is what closed the $20M
  gap; it was never an English-only decision.

  **Two overlaps survive on purpose, both pre-dating this change.** "$1 million to $5
  million" and "$5 million to $20 million" both contain exactly $5M — the reviewer's
  "Plus de 5 millions" had removed that, and reintroducing a closed range at the bottom
  of the new band brings it back in both languages. Writing it out ("More than $5 million
  to $20 million" / "Plus de 5 à 20 millions") is accurate and reads badly, so it is left
  as is. And "More than $20 million" and "Larger enterprise ($150 million or more)" both
  describe a $200M business; that one is as old as the `size-large` answer, and is
  tolerable because "Larger enterprise" reads as a category rather than a band. Neither
  affects routing — a business landing in either bucket at those exact figures sees
  nearly the same list — but both are labels a person reads, which is where the previous
  round of this argument was won.

- **Q4's catch-all is now just "Other", because live visitors were falling off it.**
  People were reaching the last question, finding none of the four answers described
  them, and stopping — a retailer, a haulier, a construction firm had nothing to pick.
  The answer they needed already existed and was mislabelled: `sec-mfg` read "Other
  manufacturing and exporting", which is far narrower than what it actually routes.
  It routes *everything* that is not forestry, steel or agriculture.

  **The label was the whole bug.** `sec-mfg` has no `sectors:` entry, so it stamps a
  marker no generated rule matches, no sector panel opens, and the visitor gets the
  sector-agnostic column, their region and the hubs — between 5 and 16 programs depending
  on the need, never zero. That behaviour is unchanged; only the words are. Nothing in
  the CSV, the bridges, the `clears:` cascades or the generated CSS moved, and the sweep
  is still 840 combinations.

  **A separate "Other sectors" answer was built first and then removed.** It worked — it
  was a second marker with no `sectors:` entry, identical to `sec-mfg` across all 1,050
  combinations the sweep then had — but two adjacent "Other" answers that route
  identically ask the visitor to make a distinction that does not exist. One answer named
  "Other" is both tidier and easier to choose, which is the same argument twice.

  **"Other" is not "none of the above"**, which is what it literally is. That wording
  reads as a rejection at the exact moment the tool should be helping, and the page
  behind it is a full set of results, not an apology.

  `test_the_catch_all_sector_never_shows_an_empty_page` is what survived the detour: the
  fall-through is only acceptable while there is something to fall through *to*, in every
  need x region x size, in both languages. It is the one guard that would have caught the
  original problem if the original problem had been mechanical rather than editorial.

- **Q1 gained a fifth need, "Retraining and hiring support", instead of a second
  workforce question.** The department wanted the workforce side fleshed out, and the
  `/eric/` employer-wizard draft proposed a new checkbox question — *"What is your
  workforce situation right now? Select all that apply"* — with five answers covering
  reduced hours, an existing Work-Sharing agreement, upskilling, hiring, and layoffs.
  That draft was not taken, for four reasons in descending weight:

  1. **It asks the visitor to self-diagnose eligibility.** "I already have a Work-Sharing
     agreement in place" is a criterion, not a need. This wizard has backed away from
     criteria-as-triage three times already — the "3 or more years operating" trim, the
     removed U.S.-exporter answer, and the DM ruling out exposure thresholds — and each
     entry above says why.
  2. **It is a conditional fifth question**, shown only on the workforce branch, so
     "Question 2 of 5" is true there and false on every other path. The four questions
     are unconditional and the counter is honest.
  3. **It is multi-select**, which breaks the one-marker-per-question model the `clears:`
     cascade depends on.
  4. **Four of its five panels re-sort programs already on the page.** Only three
     destinations in the whole draft were new.

  A fifth need is a real answer to "What do you need right now?", so it needed no new
  mechanism at all: a `needs:` entry, a Q1 option, the marker in Q1's `clears:`, and rows
  tagged `hiring`. "All of the above" picked it up for free.

  **The answer shipped as "Recruit and hire new workers" and was renamed the next day.**
  Recruiting on its own does not read as tariff support — it is the one thing in Q1 a
  visitor could arrive at without a tariff problem, sitting under a heading that promises
  help with one. Retraining moved across to join it on 2026-09-11, so the two people
  answers are now **"Workforce retention and work-sharing"** and **"Retraining and hiring
  support"**. That line is the one worth holding: the workforce answer is for keeping the
  staff you have, the hiring answer is for the ones you do not have yet, whether you
  train them or recruit them. The `csv` key is still `hiring`; only the label moved.

  **It is the only Q1 answer that says "support", and that is the point.** The other four
  name the thing you need — financing, liquidity, a project, retention — and let the page
  supply the rest, because the h1 above them already says "Find support for your
  business" / "Trouver du soutien pour votre entreprise". Hiring could not do that:
  "Retraining and hiring workers" read as something the business was *doing*, which is
  what made it the one answer a visitor could reach without a tariff problem. Naming the
  support turns it back into something the government offers. The asymmetry with the
  other four answers is the price, and it was paid deliberately. The French does the same
  thing with the same word the French h1 uses — "Soutien à la requalification et à
  l'embauche" — so the two languages are off-pattern in the same place, not two
  different places.

  **Three rows came across from the draft; one did not.** Job Bank's *Resources for
  employers* and *Available Workers Dashboard* are `hiring`. Job Bank's *Training options
  for Work-Sharing employers* is **`workforce`, not `hiring`** — and it stayed there on
  2026-09-11 when the rest of retraining moved, which makes it the one row where the
  prerequisite beats the subject. It is a retraining page, but it is only reachable by an
  employer who already has an approved Work-Sharing agreement, so it reads as part of
  that chain and sits directly below the Worker Retention Grant. Someone answering the
  hiring question cannot act on it; someone answering the work-sharing question can. All
  six URLs verified 200 in both languages on 2026-09-10.

  **What moved with the word.** *Workforce Tariff Response — EI-funded LMDAs* is `hiring`
  now: EI-funded skills training for tariff-affected workers, with no Work-Sharing
  prerequisite holding it in the retention panel. That leaves the workforce answer as the
  Work-Sharing chain and nothing else — Work-Sharing, the Worker Retention Grant that
  requires it, and the training page that requires it.

  **The Workforce Retention and Retraining Program (WRRP) is deliberately not a row.**
  Its page is live but the programme is not: it is written in the future tense and says
  plainly that "until the new Workforce Retention and Retraining Program comes into
  effect, the Work-Sharing Program and the Worker Retention Grant will continue to
  operate." Both of those are already in the wizard, so holding WRRP costs a visitor
  nothing. Add the row when the programme starts, not when the page appears.

  **The Student Work Placement Program was the first row to answer two *people* needs,
  and held that for one day.** It shipped `workforce;hiring` — a wage subsidy *and* the
  channel through which an employer takes on post-secondary students — on the same
  first-need rule the RTRI and Pivot to Grow rows use. It is `hiring` alone as of
  2026-09-11: once the workforce answer narrowed to retention and work-sharing, a subsidy
  for taking on students who do not work there yet had nothing left to say to it. No row
  bridges the two people needs now, which is the point of drawing the line where it is —
  if one appears, the line is in the wrong place.

  **The all-view's no-duplicates promise now has a direct test.** Eleven live rows name
  two needs — all money pairs now — and every one of them is a chance for a program to
  list twice under "All of the above". `test_no_program_ever_lists_twice` checks all
  1,008 combinations in both languages. Confirmed to fail by disabling the all-view's
  first-need filter, which is what the regression would actually look like. The row-level
  pin that sat beside it named the Student Work Placement Program and went stale the day
  that row became single-need; it is now two tests that pin the retention/retraining line
  itself — `test_retraining_and_hiring_rows_are_not_under_retention` and
  `test_the_work_sharing_training_page_stays_with_its_chain`.

  **Q1's workforce answer names work-sharing, in lower case on purpose.** The answer is
  "Workforce retention and work-sharing" / "Rétention ou travail partagé de la
  main-d'œuvre". Work-sharing is the single most recognisable thing behind that answer
  and every row in the panel now names it, so the cue belongs at the point where someone
  is choosing rather than after they arrive. It is
  **not** capitalised as the programme is, because the Work-Sharing Program is being
  replaced by WRRP and will be renamed: the answer names an activity, at the same level
  as retention and retraining, and survives that rename untouched. The capitalised
  "Work-Sharing Program" still appears in the results, where it is the actual thing being
  linked. Do not "correct" the label to match the programme name.

  **The results headings match their answers again.** "Workforce retention and
  retraining" was deliberately left mismatched with its answer for a day, on the grounds
  that the heading already carries the ": open to all sectors" suffix and runs long in
  French. Moving retraining out settled it: the heading could not keep a word the answer
  no longer had, so it is "Workforce retention and work-sharing" / "Maintien en poste et
  travail partagé de la main-d'œuvre", and the new one is "Retraining and hiring support"
  / "Soutien à la requalification et à l'embauche". The answer-to-heading mismatch
  flagged on the live French page above is now gone from both languages.

  **"Reconversion" is out of the French file.** It survived in exactly one place — the
  `needs:` heading for workforce — after the live Q1 answers were taken verbatim, as the
  French-review entry above records. That heading is about work-sharing now, and the
  heading that replaced it as the retraining one reads "Requalification", matching its
  own Q1 answer word for word rather than preserving a word the answers had already
  dropped. Samir Goulamaly's (DEC/CED) reasoning for "reconversion" over "recyclage" is
  still in that entry; the wizard no longer uses either.

  **What the draft had that this does not.** Its Work-Sharing answer surfaced the
  *prerequisite chain* — that the Worker Retention Grant and the Job Bank training page
  both require an approved Work-Sharing agreement. Here that lives in the rendered name,
  "Worker Retention Grant (prerequisite: Work-Sharing Program)", with the rows ordered so
  Work-Sharing reads first. Less prominent, and the fuller answer is the per-row criteria
  line in "Next steps" — which this adds a third and fourth row to.

## Next steps

1. **Spot-check the seven composed French names.** 41 of 49 were read off the live French
   page's own `<h1>`, cleaned of taglines, org suffixes and AAFC's ": 1. Ce qu'offre ce
   programme" step numbering. The `fr_source` column records the provenance of every row;
   the seven marked `composed:` carry the reason, and they are the only ones needing a
   French-language judgement call:
   - three regional IRRT pages whose own h1 omits the region
   - one stream name whose parent page covers several streams
   - CEEFC, whose h1 is the corporation name rather than the product
   - the Business Benefits Finder, whose page has no h1 at all
   - FCC's French financing page, which still carries an English title
   ("Marque Canada" is confirmed correct — its site was simply down when checked.)
2. **Resolve the remaining flagged rows.** `duplicate-url` (1), `weak` (2), `ambiguous` (1)
   and `best-guess` (1). Each `note` says what the doubt is. The one remaining
   `duplicate-url` is BDC's forestry cash-flow stream, whose twin is the `disputed`
   transformation row that never renders — so it is a flag to re-check, not a live
   double-listing.
3. **Check whether RTRI's steel targeting needs a row of its own.** The ISED national hub says
   "The RTRI includes targeted support for SME projects in the Canadian steel sector."
   Nothing is mis-routed today — the RTRI rows are `sector-agnostic`, so a steel business
   already sees them — so this is only worth acting on if the steel support is a *separate
   stream with its own page*, which would make it a row. If it is prioritization within the
   same application, it is result-card text at most, and shares a mechanism with the Quebec
   criteria below.
4. **Build the per-row criteria line.** A new CSV column (plus a French twin) rendered as
   small text under the program name, for the eligibility that size gates cannot express.
   Wanted by at least six rows today: CED's Quebec RTRI ($2M, <500 employees,
   manufacturing), EDC direct lending ($10M inside the `5mplus` bucket, and a $1M minimum
   draw), BDC's Pivot to Grow Loan (3 years in business, positive cash flow, 15% U.S.
   export share), and — added with the hiring need — the Worker Retention Grant and Job
   Bank's Work-Sharing training page, which both require an approved Work-Sharing
   agreement no Q3 answer can express, and the Canada Strong Diversification Fund, whose
   real threshold is a $20M *project cost* rather than the annual revenue Q3 asks about. Each is currently a `note` no visitor will ever
   read. This is the single highest-value thing left in this list — every straddled bucket
   above resolves to it, and so does the prerequisite chain the `/eric/` draft tried to
   solve with a whole extra question.
5. **Report the AAFC language-toggle bug.** One note records that the French AAFC hub's
   English toggle targets a 404. That is a live Canada.ca defect, unrelated to this work.
6. **Add amount, term and repayment** once the figures exist — new CSV columns and a line
   in the template.
7. **The start page does not fit a phone screen.** Each choice measures 143px at a 390px
   viewport, putting the third button about 872px down, past the ~724px a mobile browser
   leaves visible. The 271px of CDTS header and breadcrumb is most of that budget. Cheapest
   fixes: shorten each `description` to one line at 360px (~78px), drop the intro line
   (~33px), tighten the gap to `mrgn-bttm-sm` (~20px). Buttons cost only 12px more than
   plain links, so they are not the thing to cut.
8. **Consider a worker path prototype** if that page needs design work rather than a link.
9. **Consider the Kosher and Halal Investment Component** as a third AgriMarketing row.
   Research on the SME/NIA split turned this up as a further stream under the same
   program, sector-specific rather than size-specific — not added, since its own URL and
   French name still need the same live-page verification every other row got.
