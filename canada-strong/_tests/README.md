# canada-strong tests

Everything the wizard's "Verifying a change" section asks for, minus the browser.
No Jekyll needed — the harness renders the templates with the same Liquid and the
same two Jekyll array filters the real build uses.

Run from the `canada-strong` folder. The suite is anchored to this folder rather
than to the repo, so it also works on a copy of `canada-strong` on its own —
the three tests that check `_config.yml` skip when there is no repo around it.

```bash
ruby _tests/run.rb          # the whole suite
ruby _tests/test_routing.rb # one file
ruby _tests/preview.rb out  # render the pages to ./out
```

Requires the `liquid` and `nokogiri` gems; both are already installed on the
team's machines. If liquid is missing:

```bash
gem install --user-install liquid -v 4.0.4 --no-document
```

## What each file covers

| File | Checks |
|---|---|
| `test_routing.rb` | All 120 need x sector x region combinations, both languages, against the CSV. Route notes, excluded rows, internal notes, duplicate results. |
| `test_csv_data.rb` | The CSV itself: required columns, closed vocabularies, statuses, URLs, French coverage, and two decisions pinned so they cannot be undone quietly. |
| `test_eligibility.rb` | Exactly one badge per criterion for every size x sector, and nothing painted before its question is answered. |
| `test_markup.rb` | Heading order, one h1, the fieldflow chain, the reset cascade, and the traps listed under "Gotchas found the hard way". |
| `test_parity.rb` | The French templates are the English ones with the language swapped; the two YAML files stay the same shape. |
| `test_standalone.rb` | The folder carries its own data, docs and tests, and `data_dir` still points into it. |

`support/wizard.rb` renders and reads the pages, and finds the program data via
`data_dir` in the repo's `_config.yml` (falling back to `canada-strong/_data`). `support/expected.rb` works out
what the CSV *should* produce — deliberately a second implementation, so it does
not just agree with the template's bugs.

## How the routing test works

Results depend on two answers at once, so the template generates one CSS rule per
panel and fieldflow stamps marker classes on `#wz-state`. The test reads those
generated rules back, works out which panels a given set of markers reveals, and
compares the programs in them against the CSV. No browser, no clicking.

## What it cannot check

The radio buttons, fieldsets and legends are built by wb-fieldflow at runtime;
before init there is nothing to find in the static HTML. Those, and anything to
do with layout, still need a browser — see "Verifying a change" in
`canada-strong/how-this-wizard-works.md`.

## Adding a test

Pin decisions, not data. A test that restates a CSV row will pass no matter what
the row says, because both sides read the same file. The two tests worth copying
the shape of are `test_forestry_transformation_routes_to_nrcan_not_bdc` and
`test_shared_destinations_are_flagged_as_duplicates`: both encode a judgement
someone made, so undoing it has to be deliberate.
