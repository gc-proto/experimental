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
  # Crossed with every size answer too (700 total), not fixed at one size:
  # most CSV rows ignore size entirely, but a row with a `size` column (like
  # LETL) only shows for the sizes it lists, and that has to hold at every
  # need x region x sector it could appear under, not just one hand-picked
  # combination.
  Wizard::LANGS.each do |lang|
    define_method("test_every_combination_shows_the_programs_the_csv_says_#{lang}") do
      page = Wizard::BUSINESS[lang]
      failures = []

      Wizard.combinations_with_size(lang).each do |c|
        markers = [c[:need], c[:region], c[:sector], c[:size]]
        actual   = Wizard.visible_programs(page, markers).sort
        expected = Wizard::Expected.programs(lang, c[:need], c[:region], c[:sector], c[:size]).sort
        next if actual == expected

        missing = expected - actual
        extra   = actual - expected
        failures << "#{c[:need]} / #{c[:region]} / #{c[:sector]} / #{c[:size]}" \
                    "#{missing.empty? ? '' : "\n    missing: #{missing.map(&:first).join(', ')}"}" \
                    "#{extra.empty?   ? '' : "\n    extra:   #{extra.map(&:first).join(', ')}"}"
      end

      shown = failures.first(12)
      more  = failures.size > shown.size ? "\n  ... and #{failures.size - shown.size} more" : ""
      assert_empty failures,
        "#{failures.size} of #{Wizard.combinations_with_size(lang).size} combinations disagree with the CSV (#{lang}):\n  " +
        shown.join("\n  ") + more
    end

    # A combination with no sector-specific stream shows nothing sector-
    # specific at all — no panel, no "no stream for your sector" box. The
    # sector-agnostic, regional and hub panels for that need still carry the
    # page; there is nothing worth telling the business it didn't get.
    define_method("test_no_sector_panel_when_the_cell_is_empty_#{lang}") do
      page = Wizard::BUSINESS[lang]
      wrong = []

      combos_for(lang).each do |c|
        markers = [c[:need], c[:region], c[:sector], "size-1to5m"]
        shown = Wizard.visible_panels(page, markers)
                      .any? { |p| p["class"].to_s.include?("wz-p-#{Wizard.need_csv(lang, c[:need])}-#{Wizard.sector_csv(lang, c[:sector])}") }
        want = !Wizard::Expected.no_sector_stream?(
          Wizard.need_csv(lang, c[:need]), Wizard.sector_csv(lang, c[:sector]), lang
        )
        wrong << "#{c[:need]} / #{c[:sector]}: panel #{shown ? 'shown' : 'absent'}, expected #{want ? 'shown' : 'absent'}" if shown != want
      end

      assert_empty wrong.uniq, "sector panel appears where the CSV has no stream (#{lang}):\n  " + wrong.uniq.join("\n  ")
    end

    # The removed box's markup and labels must actually be gone, not just
    # unreachable — a leftover .wz-route-* rule or route_heading string would
    # mean the suppression is incomplete rather than deliberate.
    define_method("test_the_route_note_box_is_fully_removed_#{lang}") do
      page = Wizard::BUSINESS[lang]
      assert_empty Wizard.doc(page).css("[class*=wz-route-]").to_a, "#{lang}: a wz-route-* element is still in the DOM"
      refute Wizard.text(lang)["business"]["labels"].key?("route_heading"), "#{lang}: route_heading label is still defined"
      refute Wizard.text(lang)["business"]["labels"].key?("route_body"), "#{lang}: route_body label is still defined"
    end

    # A panel's own visibility is decided by need/sector/region alone; size
    # only hides individual <li>s inside it (see "How a size-gated row hides
    # itself"). Those are two separate mechanisms, so nothing stops a CSV
    # edit from restricting every row in a panel to sizes that don't add up
    # to "everyone" — the panel would still show (need/sector/region matched)
    # with a heading and an empty body for whichever size that leaves out.
    # Not a live bug today — every panel has at least one row visible at
    # every size — but a spreadsheet edit could cause it silently, so the
    # invariant is checked directly rather than trusted to hold by accident.
    define_method("test_no_panel_ever_renders_with_zero_visible_programs_#{lang}") do
      page = Wizard::BUSINESS[lang]
      wrong = []

      Wizard.combinations_with_size(lang).each do |c|
        markers = [c[:need], c[:region], c[:sector], c[:size]]
        visible = Wizard.visible_targets(page, markers)

        Wizard.visible_panels(page, markers).each do |panel|
          items = panel.css(".panel-body > ul > li")
          next if items.empty? # not a program-list panel

          next if items.any? { |li| Wizard.shown?(li, visible) }
          wrong << "#{c[:need]} / #{c[:region]} / #{c[:sector]} / #{c[:size]}: #{panel['class']}"
        end
      end

      assert_empty wrong.uniq.first(12),
        "panels rendered with a heading but no visible programs (#{lang}):\n  " + wrong.uniq.first(12).join("\n  ")
    end

    # Answering only the first question must not reveal anything: every panel
    # is gated on at least a need *and* something else, or on nothing at all.
    define_method("test_no_results_before_the_last_answer_#{lang}") do
      page = Wizard::BUSINESS[lang]
      results = Wizard.doc(page).at_css("#wz-results")
      assert_includes results["class"].to_s.split, "hidden",
        "#wz-results must start hidden; fieldflow un-hides it on the last answer"
    end

    # Size mostly doesn't change the program list at all — it only matters for
    # a CSV row that opts in via its `size` column. LETL is currently the only
    # one; pinned explicitly rather than left to the exhaustive sweep alone,
    # since "large enterprise only" is a decision someone made on purpose, not
    # just a fact the CSV happens to encode.
    define_method("test_letl_only_shows_for_size_large_#{lang}") do
      page = Wizard::BUSINESS[lang]
      letl = Wizard.rows.find { |r| r["size"].to_s.strip == "large" }
      refute_nil letl, "no row in the CSV is gated to size=large any more — was LETL's size column cleared?"
      name = Wizard::Expected.display(letl, lang).first

      Wizard.size_markers(lang).each do |sz|
        shown = Wizard.visible_programs(page, ["need-liq", "reg-atl", "sec-usexport", sz]).map(&:first)
        want  = (sz == "size-large")
        assert_equal want, shown.include?(name),
          "#{lang}: LETL #{shown.include?(name) ? 'shown' : 'hidden'} for #{sz}, expected #{want ? 'shown' : 'hidden'}"
      end
    end

    # AgriMarketing has two mutually exclusive streams for the same need x
    # sector cell: SMEs (for-profit) and NIA (non-profits, industry
    # associations). The CSV's `size` column is what tells them apart — one
    # excludes size-nonprofit, the other is size-nonprofit only. Pinned so a
    # future edit can't quietly let both, or neither, show together.
    define_method("test_agrimarketing_sme_and_nia_are_mutually_exclusive_#{lang}") do
      page = Wizard::BUSINESS[lang]
      sme = Wizard.rows.find { |r| r["program_name"].to_s.include?("Market Diversification for SMEs") }
      nia = Wizard.rows.find { |r| r["program_name"].to_s.include?("National Industry Associations") }
      refute_nil sme, "the AgriMarketing SME row is missing"
      refute_nil nia, "the AgriMarketing NIA row is missing"
      sme_name = Wizard::Expected.display(sme, lang).first
      nia_name = Wizard::Expected.display(nia, lang).first

      Wizard.size_markers(lang).each do |sz|
        shown = Wizard.visible_programs(page, ["need-tra", "reg-atl", "sec-agri", sz]).map(&:first)
        want_nia = (sz == "size-nonprofit")
        assert_equal !want_nia, shown.include?(sme_name), "#{lang}: SME stream wrong for #{sz}"
        assert_equal want_nia, shown.include?(nia_name), "#{lang}: NIA stream wrong for #{sz}"
      end
    end

    # ACOA's own eligibility for the Atlantic RTRI row requires $1M+ annual
    # revenue — pinned because it's the row that's actually empty for
    # size-under1m today (it's the only program in Atlantic's regional
    # group), so this also exercises the size-aware regional-panel fix: the
    # whole panel must vanish, not render with a heading and nothing in it.
    define_method("test_atlantic_rtri_requires_at_least_1m_revenue_#{lang}") do
      page = Wizard::BUSINESS[lang]
      row  = Wizard.rows.find { |r| r["program_name"].to_s.include?("Regional Tariff Response Initiative - Atlantic") }
      refute_nil row, "the Atlantic RTRI row is missing"
      name = Wizard::Expected.display(row, lang).first

      Wizard.size_markers(lang).each do |sz|
        markers = ["need-liq", "reg-atl", "sec-usexport", sz]
        shown   = Wizard.visible_programs(page, markers).map(&:first)
        want    = (sz != "size-under1m")
        assert_equal want, shown.include?(name),
          "#{lang}: Atlantic RTRI #{shown.include?(name) ? 'shown' : 'hidden'} for #{sz}, expected #{want ? 'shown' : 'hidden'}"

        panel_present = Wizard.visible_panels(page, markers).any? { |p| p["class"].to_s.include?("wz-rg-reg-atl-liquidity") }
        assert_equal want, panel_present,
          "#{lang}: Atlantic's regional panel #{panel_present ? 'renders' : 'is absent'} for #{sz}, expected #{want ? 'to render' : 'absent, not empty'}"
      end
    end

    # Every CSV row that restricts itself by size must use a size the wizard
    # actually asks about — a typo here would silently hide a program forever.
    define_method("test_size_restricted_rows_use_known_sizes_#{lang}") do
      known = Wizard.text(lang)["sizes"].map { |s| s["csv"] }
      bad = Wizard.rows.reject { |r| r["size"].to_s.strip.empty? }
                       .reject { |r| r["size"].split(";").map(&:strip).all? { |v| known.include?(v) } }
      assert_empty bad.map { |r| "#{r['program_name']}: size=#{r['size'].inspect}" },
        "#{lang}: rows with an unrecognised size value (known: #{known.join(', ')})"
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

      # Crossed with size, not fixed at one: two rows could share a name or
      # URL only when a *particular* size answer brings both into view (one
      # via a size-restricted row, say, another via a hub that isn't
      # restricted) — a single fixed size could miss that.
      Wizard.combinations_with_size(lang).each do |c|
        shown = Wizard.visible_programs(page, [c[:need], c[:region], c[:sector], c[:size]])
        where = "#{c[:need]} / #{c[:region]} / #{c[:sector]} / #{c[:size]}"

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

      # Manufacturing and the U.S.-exporter sector answers are documented as
      # sector-agnostic-only — no dedicated stream, so no marker of their own
      # in `sectors:`. They legitimately reveal nothing in the generated CSS.
      agnostic_only = Wizard.sector_markers(lang) - Wizard.text(lang)["sectors"].map { |s| s["marker"] }

      assert_empty used - answered, "#{lang}: CSS gates on markers no answer stamps"
      assert_empty answered - used - agnostic_only, "#{lang}: answers that reveal nothing at all"
    end
  end
end
