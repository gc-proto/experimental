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
        criteria_list(page, [size, sector, "need-fin", "reg-on"]).each do |text, badges|
          next if badges.size == 1
          wrong << "#{size} + #{sector}: \"#{text[0, 48]}\" shows #{badges.size} badges (#{badges.join(', ')})"
        end
      end

      assert_empty wrong, "#{wrong.size} criteria with the wrong badge count (#{lang}):\n  " + wrong.first(10).join("\n  ")
    end

    # Answering only some questions must not paint a criterion prematurely.
    define_method("test_no_conditional_badge_before_its_question_is_answered_#{lang}") do
      page = Wizard::BUSINESS[lang]
      visible = Wizard.visible_targets(page, ["need-fin", "reg-on"])
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
        visible = Wizard.visible_targets(page, [size, "need-fin", "reg-on", "sec-agri"])
        shown = Wizard.shown?(note, visible)
        want  = (size == "size-large")
        assert_equal want, shown, "#{lang}: large note #{shown ? 'shown' : 'hidden'} for #{size}"
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
