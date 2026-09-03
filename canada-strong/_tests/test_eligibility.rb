# frozen_string_literal: true
#
# The eligibility checklist is the one piece of routing that still lives in the
# YAML rather than the CSV. Its whole contract is "exactly one badge per
# criterion, for every answer someone can give" — a criterion showing two
# badges, or none, is a visible defect on a Canada.ca-looking page.

require "minitest/autorun"
require_relative "support/wizard"

class TestEligibility < Minitest::Test
  # Every size x sector pair a user can reach.
  def answer_pairs(lang)
    Wizard.size_markers(lang).flat_map do |size|
      Wizard.sector_markers(lang).map { |sector| [size, sector] }
    end
  end

  def criteria_list(page, markers)
    visible = Wizard.visible_targets(page, markers)
    Wizard.doc(page).css("li.wz-crit").map do |li|
      badges = li.css("span.wz-badge").select { |b| Wizard.shown?(b, visible) }
      [li.children.first.text.strip, badges.map { |b| b.text.strip }]
    end
  end

  Wizard::LANGS.each do |lang|
    define_method("test_exactly_one_badge_per_criterion_#{lang}") do
      page = Wizard::BUSINESS[lang]
      wrong = []

      answer_pairs(lang).each do |size, sector|
        criteria_list(page, [size, sector, "need-fin", "reg-on-s"]).each do |text, badges|
          next if badges.size == 1
          wrong << "#{size} + #{sector}: \"#{text[0, 48]}\" shows #{badges.size} badges (#{badges.join(', ')})"
        end
      end

      assert_empty wrong, "#{wrong.size} criteria with the wrong badge count (#{lang}):\n  " + wrong.first(10).join("\n  ")
    end

    # Answering only some questions must not paint a criterion prematurely.
    define_method("test_no_conditional_badge_before_its_question_is_answered_#{lang}") do
      page = Wizard::BUSINESS[lang]
      visible = Wizard.visible_targets(page, ["need-fin", "reg-on-s"])
      early = Wizard.doc(page).css("span.wz-badge").select { |b| Wizard.shown?(b, visible) }
                    .select { |b| b["class"].to_s.split.include?("wz-rb") }
      assert_empty early.map { |b| b.text.strip },
        "#{lang}: conditional badges visible with only need and region answered"
    end

    # The large-enterprise note is the one panel gated on size alone.
    define_method("test_large_enterprise_note_tracks_the_size_answer_#{lang}") do
      page = Wizard::BUSINESS[lang]
      note = Wizard.doc(page).at_css(".wz-large-note")
      refute_nil note, "#{lang}: the large-enterprise note is missing"

      Wizard.size_markers(lang).each do |size|
        visible = Wizard.visible_targets(page, [size, "need-fin", "reg-on-s", "sec-agri"])
        shown = Wizard.shown?(note, visible)
        want  = (size == "size-large")
        assert_equal want, shown, "#{lang}: large note #{shown ? 'shown' : 'hidden'} for #{size}"
      end
    end

    # Exactly one RDA link at the bottom of the eligibility section, matching
    # whichever region was answered — never none, and never more than one at
    # once (each region's paragraph is independently gated on its own marker).
    define_method("test_exactly_one_rda_link_for_the_chosen_region_#{lang}") do
      page = Wizard::BUSINESS[lang]
      prefix = Wizard.text(lang)["business"]["labels"]["rda_prefix"]

      Wizard.region_markers(lang).each do |m|
        visible = Wizard.visible_targets(page, [m, "need-fin", "sec-agri", "size-1to5m"])
        shown = Wizard.doc(page).css("p.wz-r").select do |p|
          p["class"].to_s.split.any? { |c| c.start_with?("wz-rda-") } && Wizard.shown?(p, visible)
        end

        assert_equal 1, shown.size, "#{lang}: #{m} reveals #{shown.size} RDA links, expected exactly 1"
        para = shown.first
        assert para.text.strip.start_with?(prefix.strip), "#{lang}: RDA paragraph for #{m} is missing rda_prefix"
        assert_includes para["class"], "wz-rda-#{m}", "#{lang}: #{m} shows a different region's RDA link"
      end
    end

    # Every region's RDA link points at that agency's own site, not the
    # region's tariff-specific program (already linked above, under "Programs
    # for your region") and not another region's agency.
    define_method("test_rda_links_point_at_the_right_agency_#{lang}") do
      Wizard.text(lang)["regions"].each do |reg|
        refute_nil reg["rda"], "#{lang}: #{reg['marker']} has no rda name"
        refute_nil reg["rda_url"], "#{lang}: #{reg['marker']} has no rda_url"
        assert reg["rda_url"].start_with?("https://"), "#{lang}: #{reg['marker']}'s rda_url is not https"
        refute_includes reg["rda_url"], "regional-tariff-response-initiative",
          "#{lang}: #{reg['marker']}'s rda_url points at the RTRI program page, not the agency's own site"
        refute_includes reg["rda_url"], "initiative-regionale-reponse-tarifaire",
          "#{lang}: #{reg['marker']}'s rda_url points at the RTRI program page, not the agency's own site"
      end

      urls = Wizard.text(lang)["regions"].map { |r| r["rda_url"] }
      assert_equal urls.uniq.size, urls.size, "#{lang}: two regions share the same rda_url"
    end

    # size-nonprofit (non-profits, associations, boards of trade) is mapped to
    # size-under1m's badges as a stand-in, not because it's actually under
    # $1M — see the comment by the question in the YAML. A data-driven test
    # can't catch this decision quietly drifting, since both sides would read
    # the same eligibility_rules; this pins the two size answers producing
    # identical badges until someone deliberately gives size-nonprofit its
    # own rules.
    define_method("test_nonprofit_size_answer_matches_under1m_badges_#{lang}") do
      page = Wizard::BUSINESS[lang]

      Wizard.sector_markers(lang).each do |sector|
        under1m    = criteria_list(page, ["size-under1m",   sector, "need-fin", "reg-atl"])
        nonprofit  = criteria_list(page, ["size-nonprofit", sector, "need-fin", "reg-atl"])
        assert_equal under1m, nonprofit,
          "#{lang}: size-nonprofit's badges no longer match size-under1m's for #{sector}"
      end
    end

    # Every rule points at a badge class the page actually contains, and every
    # conditional badge is reachable by some answer.
    define_method("test_every_rule_and_badge_is_wired_up_#{lang}") do
      page  = Wizard::BUSINESS[lang]
      rules = Wizard.text(lang)["business"]["eligibility_rules"]
      doc   = Wizard.doc(page)

      rules.each do |r|
        refute_nil doc.at_css(".#{r['show']}"),
          "#{lang}: eligibility_rules reveals .#{r['show']}, which is nowhere on the page"
      end

      conditional = doc.css(".wz-rb").flat_map { |b| b["class"].to_s.split } - %w[wz-badge wz-rb wz-met wz-notmet wz-review]
      targeted = rules.map { |r| r["show"] }
      assert_empty conditional.uniq - targeted,
        "#{lang}: badge classes no rule can ever reveal"
    end
  end

  # The badge vocabulary must not drift apart between the two languages.
  def test_badge_classes_match_across_languages
    classes = Wizard::LANGS.map do |lang|
      Wizard.text(lang)["business"]["eligibility"]["criteria"]
            .map { |c| c["badges"].map { |b| [b["status"], b["class"]] } }
    end
    assert_equal classes[0], classes[1],
      "the English and French eligibility criteria have drifted apart structurally"
  end

  def test_eligibility_rules_match_across_languages
    rules = Wizard::LANGS.map { |l| Wizard.text(l)["business"]["eligibility_rules"] }
    assert_equal rules[0], rules[1], "eligibility_rules differ between en and fr"
  end
end
