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
_data/tariff_tool_links.csv    57 rows — every program, both languages, and its routing
_data/canada_strong_en.yml     English interface text
_data/canada_strong_fr.yml     the same, in French
start-*.html                   three choices, links out
business-*.html                the wizard: questions, generated results, generated CSS
_tests/                        the suite: 113 tests over the files above
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
| `size` | blank by default — shown for every size. Set to restrict a row: `under-1m`, `nonprofit`, `1to5m`, `5mplus`, `large`, semicolons for more than one. LETL, AgriMarketing's SME/NIA split, three BDC programs (Pivot to Grow Loan, Steel and Aluminium, Softwood Lumber Guarantee), EDC direct lending, and seven of the eight RTRI rows (all but Quebec) use this today. |
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
Question 1 clears all twenty, question 2 clears region, size and sector, and so on. This
is what stops a stale panel surviving when someone changes an earlier answer.

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
five size codes none is a substring of another, so the raw-string version happened to work,
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

Manufacturing is deliberately absent from `sectors:` — it has no sector-specific stream, so
it sees the sector-agnostic results only. It is now the *only* Q4 answer like that, which
makes it the one to reach for when a test needs a sector that reveals no sector panel;
`test_letl_only_shows_for_size_large` and `test_steel_support_requires_at_least_1m_revenue`
both do exactly that.

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

- **All 560 combinations** (112 need x region x sector, crossed with every size answer),
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

Four tests pin decisions rather than data — the forestry transformation cell routing to
NRCan and not BDC, the duplicate-URL triage, and BDC's product being the "Pivot to Grow
Loan" rather than the deck's bare "Pivot to Grow". Data-driven tests cannot catch those:
both sides read the same CSV, so changing the CSV changes the expectation too. If one of
those decisions is genuinely revisited, delete the test on purpose.

## Verifying a change

Run the suite. What is left needs a browser, because wb-fieldflow builds the radios,
fieldsets and legends at runtime — before init there is nothing in the static HTML to
find.

Do **not** click through every combination: fieldflow re-renders on each answer and a
backgrounded Chrome tab throttles timers hard enough that a click-driven sweep takes
minutes and produces confusing intermediate states. The suite already covers all 560.

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

  **The national hub row is gated the same way, which only became correct once the sweep
  finished.** Since all seven RDAs require at least $1M, an under-$1M business qualifies for
  RTRI nowhere in Canada. Ungated, the hub was the only RTRI result they saw — an umbrella
  link with all seven regional panels correctly hidden beneath it, which reads as a broken
  page rather than as ineligibility. They still reach their own RDA through the `rda_url`
  link at the foot of the results, which is a homepage rather than this program. One
  residual case cannot be fixed this way: a $1M–$2M Quebec business still sees the hub with
  no Quebec panel, because CED's $2M floor falls inside a Q3 bucket.

  **`nonprofit` is in all eight gates because the floor is an *SME* criterion.** The hub
  describes RTRI as equipping "SMEs, and the organizations that support them" — two
  populations, not one — and every revenue floor that names a subject names an SME ("SMEs
  must have… at least $1 million"). A board of trade is therefore not a small SME failing a
  $1M test; it is in the other population, which has no stated floor. That is reasoning from
  the hub plus the three pages that give a subject, not a quoted non-profit rule: four RDA
  pages were read only for their revenue fragment. The national hub row's `note` is the
  canonical write-up; the other seven point at it.

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
  Loan under both financing and liquidity, and the RTRI national hub under both liquidity
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
3. **Check whether RTRI's steel targeting needs a row of its own.** The national hub says
   "The RTRI includes targeted support for SME projects in the Canadian steel sector."
   Nothing is mis-routed today — the RTRI rows are `sector-agnostic`, so a steel business
   already sees them — so this is only worth acting on if the steel support is a *separate
   stream with its own page*, which would make it a row. If it is prioritization within the
   same application, it is result-card text at most, and shares a mechanism with the Quebec
   criteria below.
4. **Build the per-row criteria line.** A new CSV column (plus a French twin) rendered as
   small text under the program name, for the eligibility that size gates cannot express.
   Wanted by at least three rows today: CED's Quebec RTRI ($2M, <500 employees,
   manufacturing), EDC direct lending ($10M inside the `5mplus` bucket, and a $1M minimum
   draw), and BDC's Pivot to Grow Loan (3 years in business, positive cash flow, 15% U.S.
   export share). Each is currently a `note` no visitor will ever read. This is the single
   highest-value thing left in this list — every straddled bucket above resolves to it.
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
