# frozen_string_literal: true
#
# Does the CSV reach the page correctly?
#
# The wizard's markdown says not to click through combinations in a browser.
# This is the other half of that split: compute the expected result for every
# need x sector x region straight from the CSV, resolve the generated CSS to
# find out which panels a given set of answer markers reveals, and diff.

require "minitest/autorun"
require_relative "support/expected"

class TestRouting < Minitest::Test
  def combos_for(lang)
    Wizard.combinations(lang)
  end

  # ── The sweep ───────────────────────────────────────────────────────────
  Wizard::LANGS.each do |lang|
    define_method("test_every_combination_shows_the_programs_the_csv_says_#{lang}") do
      page = Wizard::BUSINESS[lang]
      failures = []

      combos_for(lang).each do |c|
        markers = [c[:need], c[:region], c[:sector], "size-1to5m"]
        actual   = Wizard.visible_programs(page, markers).sort
        expected = Wizard::Expected.programs(lang, c[:need], c[:region], c[:sector]).sort
        next if actual == expected

        missing = expected - actual
        extra   = actual - expected
        failures << "#{c[:need]} / #{c[:region]} / #{c[:sector]}" \
                    "#{missing.empty? ? '' : "\n    missing: #{missing.map(&:first).join(', ')}"}" \
                    "#{extra.empty?   ? '' : "\n    extra:   #{extra.map(&:first).join(', ')}"}"
      end

      shown = failures.first(12)
      more  = failures.size > shown.size ? "\n  ... and #{failures.size - shown.size} more" : ""
      assert_empty failures,
        "#{failures.size} of #{combos_for(lang).size} combinations disagree with the CSV (#{lang}):\n  " +
        shown.join("\n  ") + more
    end

    # A combination with no sector-specific stream must say so, not go silent.
    define_method("test_route_note_appears_exactly_where_the_cell_is_empty_#{lang}") do
      page = Wizard::BUSINESS[lang]
      label = Wizard.text(lang)["business"]["labels"]["route_heading"]
      wrong = []

      combos_for(lang).each do |c|
        markers = [c[:need], c[:region], c[:sector], "size-1to5m"]
        shown = Wizard.visible_panels(page, markers)
                      .any? { |p| p.at_css(".panel-title").text.strip == label }
        want = Wizard::Expected.route_note?(
          Wizard.need_csv(lang, c[:need]), Wizard.sector_csv(lang, c[:sector]), lang
        )
        wrong << "#{c[:need]} / #{c[:sector]}: note #{shown ? 'shown' : 'absent'}, expected #{want ? 'shown' : 'absent'}" if shown != want
      end

      assert_empty wrong.uniq, "route note in the wrong places (#{lang}):\n  " + wrong.uniq.join("\n  ")
    end

    # Answering only the first question must not reveal anything: every panel
    # is gated on at least a need *and* something else, or on nothing at all.
    define_method("test_no_results_before_the_last_answer_#{lang}") do
      page = Wizard::BUSINESS[lang]
      results = Wizard.doc(page).at_css("#wz-results")
      assert_includes results["class"].to_s.split, "hidden",
        "#wz-results must start hidden; fieldflow un-hides it on the last answer"
    end

    # Size answers change the eligibility badges, never the program list.
    define_method("test_size_does_not_change_the_program_list_#{lang}") do
      page = Wizard::BUSINESS[lang]
      sizes = Wizard.size_markers(lang)
      c = combos_for(lang).first
      baseline = Wizard.visible_programs(page, [c[:need], c[:region], c[:sector], sizes.first]).sort

      sizes.drop(1).each do |s|
        got = Wizard.visible_programs(page, [c[:need], c[:region], c[:sector], s]).sort
        assert_equal baseline, got, "#{s} changed the program list"
      end
    end
  end

  # ── Rows the CSV says must never ship ───────────────────────────────────
  def test_excluded_statuses_never_render
    excluded = Wizard.text("en")["exclude_statuses"].split(" ")
    dropped  = Wizard.rows.select { |r| excluded.include?(r["status"].to_s) }
    refute_empty dropped, "exclude_statuses names statuses no row carries — the guard is untested"

    Wizard::LANGS.each do |lang|
      page  = Wizard::BUSINESS[lang]
      shown = Wizard.all_programs(page)
      names = shown.map(&:first)
      urls  = shown.map(&:last)
      kept  = Wizard::Expected.live(lang)

      dropped.each do |r|
        want_name, want_url = Wizard::Expected.display(r, lang)
        assert !names.include?(want_name),
          "#{lang}: #{r['status']} row rendered as a result (#{want_name})"

        # A dropped row's URL can legitimately still be on the page when a
        # surviving row points at the same place — that is what duplicate-url
        # rows are. Only flag a destination nothing live claims.
        next if want_url.empty?
        next if kept.any? { |k| Wizard::Expected.display(k, lang).last == want_url }
        assert !urls.include?(want_url),
          "#{lang}: #{r['status']} row's destination rendered (#{want_url})"
      end
    end
  end

  # Two links with the same text, or two different names pointing at the same
  # page, both read as a bug to someone scanning a shortlist.
  def test_no_view_repeats_a_program_or_a_destination
    Wizard::LANGS.each do |lang|
      page = Wizard::BUSINESS[lang]
      repeats = []

      Wizard.combinations(lang).each do |c|
        shown = Wizard.visible_programs(page, [c[:need], c[:region], c[:sector], "size-1to5m"])
        where = "#{c[:need]} / #{c[:region]} / #{c[:sector]}"

        dup_names = shown.map(&:first).group_by { |n| n }.select { |_, v| v.size > 1 }.keys
        dup_names.each { |n| repeats << "#{where}: \"#{n}\" listed twice" }

        by_url = shown.reject { |_, u| u.empty? }.group_by(&:last).select { |_, v| v.map(&:first).uniq.size > 1 }
        by_url.each { |u, v| repeats << "#{where}: #{v.map(&:first).join(' + ')} both link to #{u}" }
      end

      assert_empty repeats.uniq.first(12), "duplicate results (#{lang}):\n  " + repeats.uniq.first(12).join("\n  ")
    end
  end

  # `note` is the research scratchpad. It must stay out of the HTML entirely.
  def test_research_notes_never_render
    Wizard::LANGS.each do |lang|
      html = Wizard.render(Wizard::BUSINESS[lang])
      Wizard.rows.each do |r|
        note = r["note"].to_s.strip
        next if note.length < 20
        assert !html.include?(note), "#{lang}: internal note rendered for #{r['program_name']}"
      end
    end
  end

  # Every marker the CSS mentions must be an answer someone can actually give,
  # and every answer must reach at least one rule. Catches a renamed marker.
  def test_marker_vocabulary_is_closed
    Wizard::LANGS.each do |lang|
      page = Wizard::BUSINESS[lang]
      answered = Wizard.text(lang)["business"]["questions"].flat_map { |q| q["options"].map { |o| o["marker"] } }
      used = Wizard.rules(page).flat_map { |r| r[:markers] }.uniq

      assert_empty used - answered, "#{lang}: CSS gates on markers no answer stamps"
      assert_empty answered - used, "#{lang}: answers that reveal nothing at all"
    end
  end
end
