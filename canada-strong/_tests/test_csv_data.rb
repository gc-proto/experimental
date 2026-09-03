# frozen_string_literal: true
#
# _data/tariff_tool_links.csv is the routing table, and it is edited in a
# spreadsheet by people who are not reading the template. These tests are the
# guardrail on that: a typo'd need, a renamed sector or a row that quietly
# routes nowhere should fail here, not go silently missing from the page.

require "minitest/autorun"
require_relative "support/expected"

class TestCsvData < Minitest::Test
  REQUIRED = %w[need sector region program_name url_en status].freeze

  # Statuses that mean "this row is a marker, not a program".
  NON_PROGRAM = %w[route no-page disputed].freeze

  def rows
    Wizard.rows
  end

  def line_of(row)
    rows.index(row) + 2 # header, plus 1-based
  end

  def test_the_csv_loads_and_is_not_empty
    refute_empty rows, "no rows loaded from _data/tariff_tool_links.csv"
    assert_equal Wizard.site_data["tariff_tool_links"].size, rows.size
  end

  def test_every_row_fills_its_required_columns
    missing = []
    rows.each do |r|
      REQUIRED.each do |col|
        next unless r[col].to_s.strip.empty?
        # Marker rows stand in for an absence and carry no destination.
        next if col == "url_en" && NON_PROGRAM.include?(r["status"].to_s)
        missing << "line #{line_of(r)} (#{r['program_name']}): #{col} is blank"
      end
    end
    assert_empty missing, missing.join("\n  ")
  end

  # The need column is the routing. A value the YAML does not know about means
  # the row is in the CSV and on no page.
  def test_need_values_are_in_the_vocabulary
    known = Wizard.text("en")["needs"].map { |n| n["csv"] } + ["all"]
    bad = rows.reject { |r| (Wizard::Expected.needs_of(r) - known).empty? }
    assert_empty bad.map { |r| "line #{line_of(r)}: need=#{r['need']} (known: #{known.join(', ')})" }.join("\n  "),
      "rows whose need column routes nowhere"
  end

  def test_sector_values_are_in_the_vocabulary
    known = Wizard.text("en")["sectors"].map { |s| s["csv"] } + ["sector-agnostic"]
    bad = rows.reject { |r| known.include?(r["sector"].to_s) }
    assert_empty bad.map { |r| "line #{line_of(r)}: sector=#{r['sector']}" },
      "rows whose sector is not one the wizard asks about"
  end

  def test_region_values_are_in_the_vocabulary
    known = Wizard.text("en")["regions"].flat_map { |r| r["csv"].split(";") } + ["national"]
    bad = rows.reject { |r| known.include?(r["region"].to_s) }
    assert_empty bad.map { |r| "line #{line_of(r)}: region=#{r['region']}" },
      "rows in a region no answer maps to"
  end

  # Every region the wizard offers must have somewhere to send people.
  def test_every_region_answer_has_at_least_one_program
    empty = Wizard.text("en")["regions"].reject do |reg|
      Wizard::Expected.live.any? { |r| reg["csv"].split(";").include?(r["region"].to_s) }
    end
    assert_empty empty.map { |r| r["marker"] }, "region answers with no rows behind them"
  end

  # Statuses are confidence notes, not free text — an unrecognised one might be
  # meant to exclude a row and silently not.
  KNOWN_STATUSES = %w[verified added weak ambiguous best-guess duplicate-url route no-page disputed].freeze

  def test_statuses_are_from_the_known_set
    bad = rows.reject { |r| KNOWN_STATUSES.include?(r["status"].to_s) }
    assert_empty bad.map { |r| "line #{line_of(r)}: status=#{r['status'].inspect}" },
      "unrecognised status values"
  end

  def test_excluded_statuses_are_statuses_that_exist
    Wizard::LANGS.each do |lang|
      Wizard.text(lang)["exclude_statuses"].split(" ").each do |st|
        assert_includes KNOWN_STATUSES, st, "#{lang}: exclude_statuses names an unknown status #{st.inspect}"
      end
    end
  end

  def test_both_languages_exclude_the_same_statuses
    a, b = Wizard::LANGS.map { |l| Wizard.text(l)["exclude_statuses"].split(" ").sort }
    assert_equal a, b, "the two language files drop different rows"
  end

  # A route marker means "no stream specific to your sector". It only makes
  # sense on a national row for a sector that the wizard actually asks about.
  def test_route_markers_sit_where_they_can_be_read
    sectors = Wizard.text("en")["sectors"].map { |s| s["csv"] }
    rows.select { |r| r["status"] == "route" }.each do |r|
      assert_equal "national", r["region"], "line #{line_of(r)}: a route marker outside the national column"
      assert_includes sectors, r["sector"], "line #{line_of(r)}: a route marker in a sector with no answer"
      assert_equal 1, Wizard::Expected.needs_of(r).size, "line #{line_of(r)}: a route marker for several needs at once"
    end
  end

  # A route marker and a real program in the same cell contradict each other.
  def test_no_cell_is_both_routed_and_populated
    clashes = []
    Wizard.text("en")["needs"].each do |need|
      Wizard.text("en")["sectors"].each do |sec|
        cell = Wizard::Expected.live.select do |r|
          r["region"] == "national" && r["sector"] == sec["csv"] && Wizard::Expected.need?(r, need["csv"])
        end
        routed = cell.count { |r| r["status"] == "route" }
        real   = cell.count { |r| r["status"] != "route" }
        clashes << "#{sec['csv']} / #{need['csv']}: #{routed} route marker(s) alongside #{real} program(s)" if routed > 0 && real > 0
      end
    end
    assert_empty clashes, clashes.join("\n  ")
  end

  # Programs must have a real destination.
  def test_urls_are_absolute_https
    bad = []
    rows.each do |r|
      next if NON_PROGRAM.include?(r["status"].to_s)
      %w[url_en url_fr].each do |col|
        v = r[col].to_s.strip
        next if v.empty?
        bad << "line #{line_of(r)}: #{col}=#{v}" unless v.start_with?("https://")
      end
    end
    assert_empty bad, bad.join("\n  ")
  end

  def test_no_row_carries_a_stray_whitespace_key_value
    bad = rows.select { |r| r.any? { |k, v| v.is_a?(String) && v != v.strip } }
    assert_empty bad.map { |r| "line #{line_of(r)}: #{r['program_name']}" },
      "cells with leading or trailing whitespace, which breaks exact-match routing"
  end

  # The documented fallback is that a blank name_fr shows the English name, so
  # the gap is visible. That is fine for rows that never render; it is a
  # translation debt for rows that do.
  def test_every_rendered_row_has_a_french_name_and_url
    gaps = Wizard::Expected.live("fr").reject { |r| r["status"] == "route" }.select do |r|
      r["name_fr"].to_s.strip.empty? || r["url_fr"].to_s.strip.empty?
    end
    assert_empty gaps.map { |r| "line #{line_of(r)}: #{r['program_name']}" },
      "rows that render on the French page with no French name or URL"
  end

  # fr_source records the provenance of each French name; composed ones are the
  # rows still needing a French-language judgement call.
  def test_translated_rows_record_their_provenance
    missing = Wizard::Expected.live("fr")
                              .reject { |r| r["status"] == "route" || r["name_fr"].to_s.strip.empty? }
                              .select { |r| r["fr_source"].to_s.strip.empty? }
    assert_empty missing.map { |r| "line #{line_of(r)}: #{r['program_name']}" },
      "French names with no fr_source recorded"
  end

  # ── Decisions the research made, recorded so they cannot be undone quietly ──

  # The deck named a BDC forestry transformation stream the department does not
  # actually route to; NRCan's own forest hub sends forestry transformation to
  # NRCan programs. The CSV marks the BDC row `disputed` and four NRCan
  # programs took its place. Un-excluding that row would not fail any of the
  # data-driven tests above — they follow the CSV — so the decision is pinned
  # here. If a BDC forestry transformation stream ever becomes real, delete
  # this test on purpose rather than working around it.
  def test_forestry_transformation_routes_to_nrcan_not_bdc
    cell = Wizard::Expected.live.select do |r|
      r["sector"] == "forestry-and-lumber" && Wizard::Expected.need?(r, "transformation") && r["status"] != "route"
    end
    refute_empty cell, "the forestry transformation cell is empty; the NRCan programs are gone"

    bdc = cell.select { |r| r["org"].to_s.start_with?("BDC") }
    assert_empty bdc.map { |r| "line #{line_of(r)}: #{r['program_name']}" },
      "a BDC stream is back in the forestry transformation cell — see the `status` section of how-this-wizard-works.md"
  end

  # Ontario has two regional development agencies — FedNor (north) and FedDev
  # Ontario (south) — with two different regional programs. An earlier version
  # of this page asked "Ontario" once and mapped it to both CSV regions at
  # once, which showed every Ontario business both agencies' program. Pinned
  # here because a data-driven test cannot catch a regression to that: nothing
  # stops someone re-merging the two answers in the YAML, since the CSV rows
  # themselves would be unchanged either way. See the Ontario entry under
  # "what we changed" in how-this-wizard-works.md.
  def test_ontario_is_two_region_answers_not_one
    en = Wizard.text("en")["regions"]
    on = en.select { |r| r["csv"].to_s.include?("Ontario") }

    assert_equal 2, on.size, "Ontario should be two region answers (Northern and Southern), found #{on.size}"
    on.each do |r|
      refute_includes r["csv"], ";", "#{r['marker']} maps to more than one CSV region: #{r['csv']}"
    end

    assert_equal %w[Northern\ Ontario Southern\ Ontario], on.map { |r| r["csv"] }.sort,
      "the two Ontario answers should map to exactly Northern Ontario and Southern Ontario"
  end

  # Each of the seven RDAs must have somewhere to send its region's businesses,
  # not just a heading in the YAML with nothing behind it.
  def test_every_region_has_its_own_regional_program
    Wizard.text("en")["regions"].each do |reg|
      reg["csv"].split(";").each do |csv_region|
        has_program = Wizard::Expected.live.any? { |r| r["region"] == csv_region }
        assert has_program, "#{csv_region} (#{reg['marker']}) has no program routed to it"
      end
    end
  end

  # Two rows pointing at the same page must be triaged, not shipped silently:
  # the CSV has a `duplicate-url` status for exactly that. This forces a new
  # collision to be looked at rather than quietly rendering twice.
  def test_shared_destinations_are_flagged_as_duplicates
    unflagged = []
    Wizard::Expected.live.reject { |r| r["url_en"].to_s.strip.empty? }
                    .group_by { |r| r["url_en"].to_s.strip }
                    .select { |_, v| v.size > 1 }
                    .each do |url, group|
      plain = group.reject { |r| r["status"] == "duplicate-url" }
      next if plain.size <= 1
      unflagged << "#{url}\n      " + plain.map { |r| "line #{line_of(r)} [#{r['status']}] #{r['program_name']}" }.join("\n      ")
    end
    assert_empty unflagged, "rows sharing a destination with none marked duplicate-url:\n    " + unflagged.join("\n    ")
  end

  # Adding a program is meant to be one row. Two rows with the same name in the
  # same cell means someone added it twice.
  def test_no_duplicate_rows
    seen = Wizard::Expected.live.group_by { |r| [r["need"], r["sector"], r["region"], r["program_name"]] }
    dups = seen.select { |_, v| v.size > 1 }
    assert_empty dups.keys.map { |k| k.join(" / ") }, "identical rows in the CSV"
  end
end
