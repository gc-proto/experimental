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
      needs = Wizard.text(lang)["needs"].map { |n| n["csv"] }
      wrong = []

      combos_for(lang).each do |c|
        markers = [c[:need], c[:region], c[:sector], "size-1to5m"]
        sec_csv = Wizard.sector_csv(lang, c[:sector])
        all     = Wizard.all_needs?(lang, c[:need])

        # Matched as whole class names, not substrings: "wz-p-financing-" is a
        # prefix of "wz-p-financing-agnostic", so a substring test called the
        # sector-agnostic column a sector panel and passed for the wrong reason.
        wanted_classes =
          if sec_csv.nil? then []
          elsif all       then needs.map { |n| "wz-ap-#{n}-#{sec_csv}" }
          else                 ["wz-p-#{Wizard.need_csv(lang, c[:need])}-#{sec_csv}"]
          end

        shown = Wizard.visible_panels(page, markers)
                      .any? { |p| (p["class"].to_s.split & wanted_classes).any? }

        # A sector answer with no `sectors:` entry (manufacturing) has no
        # dedicated stream at all. Under "All of the above" the sector shows a
        # panel if it has any stream under any need.
        want =
          if sec_csv.nil? then false
          elsif all       then Wizard::Expected.all_needs(sec_csv, [], lang).any? { |r| r["sector"] == sec_csv }
          else                 !Wizard::Expected.no_sector_stream?(Wizard.need_csv(lang, c[:need]), sec_csv, lang)
          end

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
        shown = Wizard.visible_programs(page, ["need-liq", "reg-atl", "sec-mfg", sz]).map(&:first)
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

    # BDC's product is the "Pivot to Grow Loan". The deck called it "Pivot to
    # Grow", and that shorter form survives on purpose in the row's
    # `slide_label` — which never renders — so the two live side by side in one
    # row and a future edit could easily promote the wrong one. Pinned on the
    # rendered name only: the bare form must never reach a user.
    define_method("test_pivot_to_grow_is_named_in_full_#{lang}") do
      page = Wizard::BUSINESS[lang]
      row  = Wizard.rows.find { |r| r["url_en"].to_s.include?("pivot-grow-loan") }
      refute_nil row, "the BDC Pivot to Grow Loan row is missing"
      name = Wizard::Expected.display(row, lang).first

      assert_match(/Pivot to Grow Loan|Pivoter pour se propulser/, name,
        "#{lang}: rendered name is \"#{name}\" — BDC's product is the \"Pivot to Grow Loan\"")

      # And the bare deck form must not be anywhere a user can read it.
      body = Wizard.doc(page).at_css("body").text
      refute_match(/Pivot to Grow(?! Loan)/, body,
        "#{lang}: the deck's bare \"Pivot to Grow\" reached the rendered page")
    end

    # BDC's steel/aluminium program requires $1M+ annual revenue and is the
    # ONLY program in the steel liquidity sector cell, so gating it is what
    # forced the sector-cell panel to get the same size-aware treatment the
    # regional panel already had. The sibling of the Atlantic pin below: that
    # one exercises the regional fix, this one the sector-cell fix. Both assert
    # the panel vanishes rather than rendering a heading over an empty list.
    define_method("test_steel_support_requires_at_least_1m_revenue_#{lang}") do
      page = Wizard::BUSINESS[lang]
      row  = Wizard.rows.find { |r| r["url_en"].to_s.include?("steel-aluminium-support-program") }
      refute_nil row, "the BDC steel and aluminium row is missing"
      name = Wizard::Expected.display(row, lang).first

      Wizard.size_markers(lang).each do |sz|
        markers = ["need-liq", "reg-atl", "sec-steel", sz]
        shown   = Wizard.visible_programs(page, markers).map(&:first)
        want    = (sz != "size-under1m")
        assert_equal want, shown.include?(name),
          "#{lang}: steel support #{shown.include?(name) ? 'shown' : 'hidden'} for #{sz}, expected #{want ? 'shown' : 'hidden'}"

        panel_present = Wizard.visible_panels(page, markers).any? { |p| p["class"].to_s.include?("wz-p-liquidity-steel-and-aluminum") }
        assert_equal want, panel_present,
          "#{lang}: steel liquidity panel #{panel_present ? 'rendered' : 'absent'} for #{sz} — it holds only this one program, so it must vanish entirely, not render empty"
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
        markers = ["need-liq", "reg-atl", "sec-mfg", sz]
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

  # ── "All of the above" ──────────────────────────────────────────────────

  # The promise of Q1's last answer, stated as the visitor would: it shows
  # everything the four separate answers would have shown, and nothing else.
  # The sweep already checks the all-view against the CSV; this checks it
  # against the wizard's own other answers, which is the claim being made to
  # the business that picks it.
  Wizard::LANGS.each do |lang|
    define_method("test_all_of_the_above_is_exactly_the_union_of_the_four_needs_#{lang}") do
      page  = Wizard::BUSINESS[lang]
      all_m = Wizard.all_needs_marker(lang)
      needs = Wizard.need_markers(lang) - [all_m]
      refute_nil all_m, "#{lang}: no all_needs_marker in the YAML"
      wrong = []

      Wizard.region_markers(lang).each do |reg|
        Wizard.sector_markers(lang).each do |sec|
          Wizard.size_markers(lang).each do |sz|
            union = needs.flat_map { |n| Wizard.visible_programs(page, [n, reg, sec, sz]) }.uniq.sort
            shown = Wizard.visible_programs(page, [all_m, reg, sec, sz]).sort
            next if shown == union

            missing = union - shown
            extra   = shown - union
            wrong << "#{reg} / #{sec} / #{sz}" \
                     "#{missing.empty? ? '' : "\n    missing: #{missing.map(&:first).join(', ')}"}" \
                     "#{extra.empty?   ? '' : "\n    extra:   #{extra.map(&:first).join(', ')}"}"
          end
        end
      end

      assert_empty wrong.first(8),
        "\"All of the above\" is not the union of the four needs (#{lang}):\n  " + wrong.first(8).join("\n  ")
    end
  end

  # Where a program lands under "All of the above" is decided by the order
  # inside its `need` cell — first need wins — and that is a property of the
  # data, not of the template. Pinned on the two rows it currently decides, so
  # reordering a cell in the spreadsheet is a visible choice rather than an
  # accident.
  def test_a_two_need_program_is_filed_under_the_first_need_it_names
    page  = Wizard::BUSINESS["en"]
    all_m = Wizard.all_needs_marker("en")
    pivot = Wizard.rows.find { |r| r["program_name"] == "Pivot to Grow Loan" }
    assert_equal "financing;liquidity", pivot["need"], "the row this test pins has been re-ordered"

    panels = Wizard.visible_panels(page, [all_m, "reg-atl", "sec-agri", "size-1to5m"])
    holding = panels.select do |p|
      Wizard.panel_programs(p).any? { |n, _| n == "Pivot to Grow Loan" }
    end
    assert_equal 1, holding.size, "Pivot to Grow Loan appears in #{holding.size} panels under All of the above"
    assert_includes holding.first.at_css(".panel-title").text, "Financing",
      "filed under the second need it names, not the first"
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
  # ── Q3's $20M band exists for exactly one row ──────────────────────────────
  #
  # The band was added so SRF-CSDF could be gated to the top of the scale: it
  # shows only for "$20 million or more" or "Larger enterprise", and only under
  # liquidity, transformation or all-of-the-above. Both sides of a data-driven
  # test would read the same CSV, so this pins the decision instead.
  %w[en fr].each do |lang|
    define_method("test_srf_shows_only_at_20m_plus_and_large_#{lang}") do
      page  = Wizard::BUSINESS[lang]
      # Match the distinctive half: the parent fund's name also appears in the
      # brackets, so keying on that would survive an accidental rename.
      label = lang == "en" ? "Canada Strong Diversification Fund" : "Fonds de diversification pour un Canada fort"
      ok_needs = %w[need-liq need-tra need-all]
      ok_sizes = %w[size-20mplus size-large]
      seen = []
      Wizard.combinations_with_size(lang).each do |c|
        markers = [c[:need], c[:region], c[:sector], c[:size]]
        next unless Wizard.visible_programs(page, markers).map(&:first).any? { |p| p.include?(label) }
        seen << [c[:need], c[:size]]
        assert_includes ok_needs, c[:need],
          "#{label} showed for #{c[:need]} (#{markers.join(', ')})"
        assert_includes ok_sizes, c[:size],
          "#{label} showed for #{c[:size]} (#{markers.join(', ')})"
      end
      assert_equal ok_needs.product(ok_sizes).sort, seen.uniq.sort,
        "#{label} did not appear for every need x size pair it is meant to"
    end

    # The band was split out of "$5 million or more", so the lower half must
    # still show everything that answer showed before the split. Anything else
    # moving between the two bands is a gate that was widened by accident.
    define_method("test_the_20m_band_differs_from_5m_only_by_srf_#{lang}") do
      page  = Wizard::BUSINESS[lang]
      # Match the distinctive half: the parent fund's name also appears in the
      # brackets, so keying on that would survive an accidental rename.
      label = lang == "en" ? "Canada Strong Diversification Fund" : "Fonds de diversification pour un Canada fort"
      moved = []
      Wizard.combinations(lang).each do |c|
        base = [c[:need], c[:region], c[:sector]]
        a = Wizard.visible_programs(page, base + ["size-5mplus"]).map(&:first).sort
        b = Wizard.visible_programs(page, base + ["size-20mplus"]).map(&:first).sort
        moved.concat(((b - a) + (a - b)).reject { |p| p.include?(label) })
      end
      assert_empty moved.uniq,
        "programs other than #{label} differ between the $5-20M and $20M+ answers"
    end
  end

  # ── The catch-all sector answer always lands somewhere ─────────────────────
  #
  # sec-mfg ("Other") is the one Q4 answer with no `sectors:` entry, so it
  # reveals no sector panel by design and the visitor falls through to the
  # sector-agnostic column, their region and the hubs. That is only acceptable
  # while the fall-through is non-empty: a visitor who answers all four
  # questions and is shown nothing is the failure this answer exists to
  # prevent, so it must not become the failure it introduces.
  %w[en fr].each do |lang|
    define_method("test_the_catch_all_sector_never_shows_an_empty_page_#{lang}") do
      page = Wizard::BUSINESS[lang]
      empty = []
      Wizard.need_markers(lang).each do |n|
        Wizard.region_markers(lang).each do |r|
          Wizard.size_markers(lang).each do |sz|
            markers = [n, r, sz, "sec-mfg"]
            empty << markers.join(", ") if Wizard.visible_programs(page, markers).empty?
          end
        end
      end
      assert_empty empty, "answer combinations that produce no programs at all"
    end
  end

  # ── The hiring need, and the row that answers two needs ────────────────────
  #
  # "Recruit and hire new workers" was added as a fifth Q1 need rather than as
  # the extra workforce question the /eric/ draft proposed - that draft asked
  # the visitor to self-diagnose eligibility ("I already have a Work-Sharing
  # agreement"), which is the kind of criteria-as-triage this wizard has backed
  # away from three times. The Student Work Placement Program is the one row
  # filed under both needs, so it is the one that could list twice.
  %w[en fr].each do |lang|
    define_method("test_student_work_placement_answers_both_needs_once_#{lang}") do
      page  = Wizard::BUSINESS[lang]
      label = lang == "en" ? "Student Work Placement" : "stages pratiques"
      %w[need-wrk need-hire].each do |n|
        names = Wizard.visible_programs(page, [n, "reg-on-s", "size-1to5m", "sec-mfg"]).map(&:first)
        assert names.any? { |p| p =~ /#{label}/i },
          "the student placement row is missing from #{n}"
      end
      # In the all-view it must appear once, under the FIRST need its cell
      # names - workforce - not under both.
      markers = ["need-all", "reg-on-s", "size-1to5m", "sec-mfg"]
      hits = Wizard.visible_programs(page, markers).map(&:first).select { |p| p =~ /#{label}/i }
      assert_equal 1, hits.size,
        "the student placement row lists #{hits.size} times under all-of-the-above"
    end

    # The all-view promises the union of the four needs with nothing repeated.
    # A second dual-need row is exactly how that quietly stops being true.
    define_method("test_no_program_ever_lists_twice_#{lang}") do
      page = Wizard::BUSINESS[lang]
      dupes = []
      Wizard.combinations_with_size(lang).each do |c|
        names = Wizard.visible_programs(page, [c[:need], c[:region], c[:sector], c[:size]]).map(&:first)
        repeated = names.group_by { |x| x }.select { |_, v| v.size > 1 }.keys
        dupes << "#{[c[:need], c[:region], c[:size], c[:sector]].join(', ')}: #{repeated.join('; ')}" unless repeated.empty?
      end
      assert_empty dupes, "answer combinations that list the same program more than once"
    end
  end

end
