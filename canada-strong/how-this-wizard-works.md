# Canada Strong tariff support tool — how it works

A wb-fieldflow wizard that routes businesses affected by U.S. tariffs to the federal
programs that fit them. Built from `canada-strong-tariff-tool-LB_Sept_01.pdf` (5 slides).

Live on test.canada.ca:

- [start-en.html](https://test.canada.ca/experimental/canada-strong/start-en.html) — the splitter question
- [business-en.html](https://test.canada.ca/experimental/canada-strong/business-en.html) — the four-question wizard

## The short version

**All text and all logic live in `_data/canada_strong_en.yml`.** The two HTML files are
Liquid loops with no hardcoded copy. If you are changing what the wizard says or what it
returns, you almost certainly want the YAML and not the HTML.

```
_data/canada_strong_en.yml     343 lines — 4 questions, 19 panels, 39 matrix rows, 37 programs
canada-strong/start-en.html    3 cards, links out
canada-strong/business-en.html the wizard: questions, results, and the generated CSS
```

## How the filtering actually works

The results depend on **two answers at once** — the need from question 1 and the sector
from question 4. A fieldflow option can only reveal one fixed target, so it cannot express
"show this when the answer is X *and* Y".

The way around it: **each answer stamps a marker class on one wrapper div, and CSS decides
what that combination means.**

1. Every answer carries an `addClass` action that stamps its marker on `#wz-state`:
   `need-liq`, `reg-on`, `size-1to5m`, `sec-agri`. There are 19 markers, one per answer.
2. Every result panel is hidden by default (`.wz-r { display: none }`) and carries a class
   naming it, e.g. `wz-liq-agri`.
3. The `matrix:` list in the YAML says which marker combination reveals which panel. At
   build time it compiles to one CSS rule per row:

   ```yaml
   - {when: "sec-agri need-liq", show: wz-liq-agri}
   ```
   ```css
   #wz-state.sec-agri.need-liq .wz-liq-agri { display: block; }
   ```

Because `#wz-state.sec-agri.need-liq` (specificity 1,3,0) outranks `.wz-r` (0,1,0), the
matching panel wins. No JavaScript of our own — fieldflow stamps the classes, CSS does
the rest.

**Resetting.** Each question's `clears:` string lists every marker it invalidates.
Question 1 clears all 19; question 2 clears region, size and sector; and so on. This is
what stops a stale panel surviving when someone changes an earlier answer. It is wired to
fieldflow's `default` action, which fires on every change to that question.

## Making changes

| To do this | Change this |
|---|---|
| Change the programs in a result | That panel's `programs:` list under `panels:` |
| Change which answers reveal a panel | The one `matrix:` line naming it |
| Reword a question or an answer | `questions: → legend` or `options: → label` |
| Add a program link | Replace `href="#"` — see "Program links" below |
| Add a new sector | See the recipe below |
| Add French | Copy the YAML to `_data/canada_strong_fr.yml`, translate the values, copy the two pages to `*-fr.html` pointing at it |

**Never edit the generated CSS block** in `business-en.html`. It is rebuilt from
`matrix:` on every Jekyll build and your edit will be overwritten.

### Recipe: adding a sector

1. Add the answer to question 4's `options:` with a new marker, e.g. `sec-fish`.
2. Add that marker to question 4's `clears:` string, **and** to question 1's, 2's and 3's
   `clears:` strings. Miss one and the marker will survive a back-track and leak a panel
   into an unrelated result.
3. Add a panel per populated cell, e.g. `wz-liq-fish`.
4. Add four `matrix:` lines — one per need. Use `show: wz-agnostic-only` for the cells
   with no stream of their own, so the empty cells stay explicit rather than silently
   showing nothing.

### Program links

All 37 program links are `href="#"` placeholders. They come from the `programs:` lists,
so to make them real, add an `href` key and update the template line in
`business-en.html` that currently hardcodes `href="#"`.

## Gotchas found the hard way

- **fieldflow's generated markup is a sibling, not a child.** After init, `#question-1` is
  hidden and the real `<fieldset>` with the radios is inserted *next to* it. Selectors
  like `#question-1 input[type=radio]` find nothing. This looks like a total failure and
  is not one.
- **Do not use Bootstrap's `.hidden` for anything the matrix controls.** It is
  `display: none !important`, which no matrix rule can override. That is why the panels
  use `.wz-r`. `.hidden` is still correct for `#wz-results` as a whole, which fieldflow
  toggles directly.
- **The CDTS theme is served from `cdts.service.canada.ca`, not `www.canada.ca`.** Both
  copies of `theme.min.js` bundle wb-fieldflow — including the newer `gcChckbxrdio` option
  that produces the GC-styled radio buttons — so no extra `<script>` tag is needed. The
  older local copy at `en/assets/wb-fieldflow.min.js` predates `gcChckbxrdio`; do not use it.
- **`layout: null`** in the front matter is what lets the raw CDTS HTML through while
  still running Liquid. Without front matter entirely, Jekyll copies the file verbatim and
  the Liquid tags ship to the browser as literal text.

## Previewing before you push

Jekyll does not run on the team's machines (system Ruby 2.6, bundler mismatch), and that
is fine — test.canada.ca is the target. But if you want to see output locally without
pushing, the `liquid` gem alone is enough:

```bash
gem install --user-install liquid -v 4.0.4 --no-document
```

```ruby
# render.rb — put this at the repo root, then: mkdir out && ruby render.rb ./out
require "yaml"
$LOAD_PATH.unshift(*Dir[File.expand_path("~/.gem/ruby/2.6.0/gems/*/lib")])
require "liquid"

root = __dir__
data = {}
Dir["#{root}/_data/*.yml"].each { |f| data[File.basename(f, ".yml")] = YAML.load_file(f) }

Dir["#{root}/canada-strong/*.html"].each do |f|
  body = File.read(f).sub(/\A---\s*\n.*?\n---\s*\n/m, "")   # strip front matter as Jekyll does
  out  = Liquid::Template.parse(body).render({ "site" => { "data" => data } })
  File.write(File.join(ARGV[0], File.basename(f)), out)
end
```

Then `python3 -m http.server` from the output directory. A local server is required —
the CDTS closure scripts do not run reliably from `file://`.

## Verifying a change

The fast way to test all 20 need × sector combinations is **not** to click through them.
Fieldflow re-renders on every answer, and a backgrounded Chrome tab throttles timers hard
enough that a click-driven sweep takes minutes and produces confusing intermediate states.

Split the test in two:

1. **Does fieldflow stamp the right markers?** Click through one full path by hand and
   watch `document.getElementById("wz-state").className` after each answer. Then change an
   earlier answer and confirm the marker cascade clears and the results re-hide.
2. **Does the matrix reveal the right panels?** Set the state directly and read what is
   visible — instant, and it covers every combination:

   ```js
   const st = document.getElementById("wz-state"), res = document.getElementById("wz-results");
   res.classList.remove("hidden");
   st.className = "need-liq reg-on size-1to5m sec-agri";
   [...res.querySelectorAll("section")].filter(s => s.offsetParent !== null)
     .map(s => s.querySelector(".panel-title").textContent.trim());
   ```

Worth checking every time: heading order runs h1 → h2 → h3 with no skips, every radio sits
inside a `<fieldset>` with a `<legend>`, and exactly one eligibility badge is visible per
criterion.

## Where the content came from, and what we changed

The deck is the source for every program name and every routing decision. Three
deliberate departures:

- **Slide 3 is not a separate page.** The deck says the employer "is directed to these
  programs" once workforce retention is the identified need, so those four programs are
  the `wz-need-wrk` result panel.
- **Slide 5 is not built.** The worker card on the start page links to the live Canada.ca
  worker supports page instead.
- **Amount, term and repayment are not shown.** Slide 4 says each result should show them
  up front, but the deck gives no figures, and inventing numbers on a Canada.ca-looking
  page is not acceptable. The eligibility met / not met / needs review marking, which the
  deck does specify, is built.

## Next steps

1. **Replace the 37 placeholder links** with real intake URLs. This is the largest
   remaining gap and the one that makes the prototype misleading if it is user-tested as is.
2. **Add amount, term and repayment** per program once the figures are confirmed — add
   `amount`, `term` and `repayment` keys to each entry in `programs:` and render them.
3. **Build the French pages** — `_data/canada_strong_fr.yml` plus `start-fr.html` and
   `business-fr.html`, and point the CDTS `lngLinks` at each other instead of at the live
   Canada.ca page.
4. **Confirm the routing decisions with the policy leads**, specifically:
   - the RDA names, and whether Ontario should list both FedDev Ontario and FedNor
   - whether the eligibility status per size band is the intended reading of slide 2's
     filter list
   - whether "manufacturing and other exporters" and the U.S.-exporter option really have
     no sector-specific stream, or whether that is a gap in the deck rather than in policy
5. **Decide on the start page.** It is three cards today because slide 1 mocks it that way
   and the bullets need somewhere to live. It could become a fieldflow radio question with
   a Continue button for consistency with the wizard.
6. **Consider a worker path prototype** if the live page turns out to need design work
   rather than just a link.
