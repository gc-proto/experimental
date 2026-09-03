# frozen_string_literal: true
#
# The eligibility criteria checklist was removed as confusing; the one thing
# from that section worth keeping — the link to the business's own regional
# development agency — now sits on its own, just above "Start over". This
# file covers what's left: exactly one RDA link, pointing at the right place,
# in the right spot on the page.

require "minitest/autorun"
require_relative "support/wizard"

class TestRda < Minitest::Test
  Wizard::LANGS.each do |lang|
    # Exactly one RDA link for whichever region was answered — never none,
    # and never more than one at once (each region's paragraph is
    # independently gated on its own marker).
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

    # The RDA link now sits directly above "Start over", with nothing in
    # between — that's the whole point of moving it out of the eligibility
    # section. Checked in the raw markup rather than the DOM, since the RDA
    # paragraphs for every region are all present at once (only one is ever
    # visible) and a DOM-order check would need to reason about which one.
    define_method("test_rda_link_sits_directly_above_start_over_#{lang}") do
      page = Wizard::BUSINESS[lang]
      body = Wizard.body(page)
      rda_block = body[/\{% for reg in t\.regions %\}<p class="wz-r wz-rda-.*?\{% endfor %\}/m]
      refute_nil rda_block, "#{lang}: no RDA paragraph loop found in #{page}"

      back_link = body[/<p class="mrgn-tp-lg"><a href="\{\{ b\.back_href \}\}">.*?<\/a><\/p>/]
      refute_nil back_link, "#{lang}: no back-link paragraph found in #{page}"

      between = body[(body.index(rda_block) + rda_block.length)...body.index(back_link)].to_s.strip
      assert_empty between, "#{lang}: something other than whitespace sits between the RDA link and Start over"
    end
  end

  # The eligibility criteria checklist — heading, criteria list, badges,
  # large-enterprise note, and the YAML config behind them — must be fully
  # gone, not just unreachable. A leftover class or label would mean the
  # removal was incomplete.
  def test_the_eligibility_section_is_fully_removed
    Wizard::LANGS.each do |lang|
      page = Wizard::BUSINESS[lang]
      doc  = Wizard.doc(page)

      %w[wz-crit wz-badge wz-met wz-notmet wz-review wz-rb wz-large-note].each do |cls|
        assert_empty doc.css(".#{cls}").to_a, "#{lang}: a .#{cls} element is still in the DOM"
      end

      refute Wizard.text(lang)["business"].key?("eligibility"), "#{lang}: eligibility config is still defined"
      refute Wizard.text(lang)["business"].key?("eligibility_rules"), "#{lang}: eligibility_rules is still defined"
    end
  end
end
