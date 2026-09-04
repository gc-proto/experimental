# frozen_string_literal: true
#
# Structure checks the wizard's markdown calls for on every change: heading
# order, the fieldflow wiring, the reset cascade, and the traps the markdown
# records as "found the hard way".

require "minitest/autorun"
require_relative "support/expected"

class TestMarkup < Minitest::Test
  Wizard::ALL_PAGES.each do |page|
    slug = page.sub(".html", "").tr("-", "_")

    define_method("test_renders_without_liquid_errors_#{slug}") do
      _out, errors = Wizard.render_result(page)
      assert_empty errors.map(&:message), "#{page} raised Liquid errors"
    end

    # `layout: null` is what runs Liquid while letting the raw CDTS HTML
    # through. Lose the front matter and the Liquid tags ship as literal text.
    define_method("test_front_matter_keeps_liquid_running_#{slug}") do
      fm = Wizard.front_matter(page)
      refute_nil fm, "#{page} has no front matter; Jekyll would copy it verbatim"
      assert fm.key?("layout") && fm["layout"].nil?, "#{page} needs `layout: null`"
    end

    define_method("test_no_unrendered_liquid_reaches_the_browser_#{slug}") do
      html = Wizard.render(page)
      refute_match(/\{\{|\{%/, html, "#{page} still contains Liquid markup after rendering")
    end

    define_method("test_one_h1_and_no_skipped_heading_levels_#{slug}") do
      main = Wizard.doc(page).at_css("main")
      refute_nil main, "#{page} has no <main>"

      levels = main.css("h1,h2,h3,h4,h5,h6").map { |h| [h.name[1].to_i, h.text.strip] }
      assert_equal 1, levels.count { |l, _| l == 1 }, "#{page} must have exactly one h1"
      assert_equal 1, levels.first[0], "#{page}'s first heading is not the h1"

      levels.each_cons(2) do |(a, _), (b, txt)|
        assert b <= a + 1, "#{page}: h#{a} jumps straight to h#{b} at \"#{txt[0, 50]}\""
      end
    end

    define_method("test_every_link_has_a_destination_#{slug}") do
      empty = Wizard.doc(page).css("a").select { |a| a["href"].to_s.strip.empty? }
      assert_empty empty.map(&:text), "#{page} has links with no href"
    end

    # The language toggle must cross to the other language, not point at itself.
    define_method("test_language_toggle_crosses_languages_#{slug}") do
      html = Wizard.render(page)
      m = html.match(/"lngLinks":\s*\[\{\s*"lang":\s*"(\w+)",\s*"href":\s*"([^"]+)"/m)
      refute_nil m, "#{page} has no parseable lngLinks"
      other, href = m[1], m[2]

      this_lang = page.end_with?("-fr.html") ? "fr" : "en"
      refute_equal this_lang, other, "#{page}'s toggle offers its own language"
      refute_equal page, href, "#{page}'s language toggle links to itself"
      assert href.end_with?("-#{other}.html"), "#{page}'s toggle says #{other} but links to #{href}"
    end

    # French pages must load wet-fr.js or WET's own strings — the "(required)"
    # after each legend — come out in English on a French page.
    define_method("test_loads_the_matching_wet_bundle_#{slug}") do
      html = Wizard.render(page)
      lang = page.end_with?("-fr.html") ? "fr" : "en"
      other = lang == "fr" ? "en" : "fr"
      assert_includes html, "wet-#{lang}.js", "#{page} must load wet-#{lang}.js"
      refute_includes html, "wet-#{other}.js", "#{page} loads the wrong WET bundle"
      assert_match(/<html[^>]*lang="#{lang}"/, html, "#{page} declares the wrong lang")
    end
  end

  # ── The business wizard's questions ────────────────────────────────────
  Wizard::LANGS.each do |lang|
    define_method("test_four_questions_in_a_fieldflow_chain_#{lang}") do
      doc = Wizard.doc(Wizard::BUSINESS[lang])
      qs  = Wizard.text(lang)["business"]["questions"]
      assert_equal 4, qs.size, "the wizard is documented as four questions"

      qs.each_with_index do |q, i|
        div = doc.at_css("##{q['id']}")
        refute_nil div, "#{lang}: #{q['id']} is missing from the page"
        classes = div["class"].to_s.split

        if i.zero?
          assert_includes classes, "wb-fieldflow", "#{lang}: the first question starts the chain"
          refute_includes classes, "hidden", "#{lang}: the first question must be visible"
        else
          assert_includes classes, "wb-fieldflow-sub", "#{lang}: #{q['id']} is a sub-question"
          assert_includes classes, "hidden", "#{lang}: #{q['id']} must start hidden"
        end

        # fieldflow builds the fieldset/legend from this <p> and <ul>; before
        # init there is no <input> to find, which is expected, not failure.
        refute_nil div.at_css("p"), "#{lang}: #{q['id']} has no legend text"
        assert_equal q["options"].size, div.css("ul > li").size,
          "#{lang}: #{q['id']} renders the wrong number of answers"
      end
    end

    # Each question must clear every marker a later question stamps, or a
    # stale panel survives when someone changes an earlier answer.
    define_method("test_each_question_clears_everything_downstream_#{lang}") do
      qs = Wizard.text(lang)["business"]["questions"]

      qs.each_with_index do |q, i|
        downstream = qs[i..-1].flat_map { |later| later["options"].map { |o| o["marker"] } }
        clears = q["clears"].to_s.split(" ")

        assert_empty downstream - clears,
          "#{lang}: #{q['id']} leaves #{(downstream - clears).join(', ')} stamped when the answer changes"
        assert_empty clears - downstream,
          "#{lang}: #{q['id']} clears #{(clears - downstream).join(', ')}, which it cannot have stamped"
      end
    end

    define_method("test_each_question_chains_to_the_next_#{lang}") do
      qs = Wizard.text(lang)["business"]["questions"]
      qs.each_with_index do |q, i|
        if i == qs.size - 1
          assert_nil q["next"], "#{lang}: the last question must reveal the results, not chain on"
        else
          assert_equal qs[i + 1]["id"], q["next"], "#{lang}: #{q['id']} chains to the wrong question"
        end
      end
    end

    # Bootstrap's .hidden is display:none !important, which no generated rule
    # can override. Panels must use .wz-r instead.
    define_method("test_conditional_panels_do_not_use_bootstrap_hidden_#{lang}") do
      doc = Wizard.doc(Wizard::BUSINESS[lang])
      clash = doc.css(".wz-r, .wz-sz").select { |n| n["class"].to_s.split.include?("hidden") }
      assert_empty clash.map { |n| n["class"] },
        "#{lang}: .hidden on a generated-rule target can never be overridden"

      style = Wizard.stylesheet(Wizard::BUSINESS[lang])
      assert_match(/\.wz-r\s*\{\s*display:\s*none/, style, "#{lang}: .wz-r has no hiding rule")
      assert_match(/\.wz-sz\s*\{\s*display:\s*none/, style, "#{lang}: .wz-sz has no hiding rule")
    end

    define_method("test_every_result_panel_has_a_heading_#{lang}") do
      panels = Wizard.doc(Wizard::BUSINESS[lang]).css("section.panel")
      refute_empty panels, "#{lang}: no result panels were generated"
      missing = panels.reject { |p| p.at_css(".panel-heading h3") }
      assert_empty missing.map { |p| p["class"] }, "#{lang}: panels without an h3"
    end

    # The promoted Business Benefits Finder line. It is a <p>, not a list item,
    # so the routing sweep cannot see it — it is checked here instead: present
    # once, inside the More options panel, closing it below the hub list,
    # carrying the CSV's own name and URL for the language.
    define_method("test_the_featured_finder_line_closes_the_hub_panel_#{lang}") do
      row = Wizard::Expected.live(lang).find { |r| r["need"] == "featured" }
      refute_nil row, "#{lang}: no need=featured row to render"
      name = lang == "fr" ? row["name_fr"] : row["program_name"]
      url  = lang == "fr" ? row["url_fr"]  : row["url_en"]
      labels = Wizard.text(lang)["business"]["labels"]

      panel = Wizard.doc(Wizard::BUSINESS[lang]).css("section.panel").find do |sec|
        sec.at_css(".panel-heading h3")&.text&.strip == labels["hub_heading"]
      end
      refute_nil panel, "#{lang}: no panel headed #{labels['hub_heading'].inspect}"

      links = panel.css(".panel-body > p a").select { |a| a["href"] == url }
      assert_equal 1, links.size, "#{lang}: expected one featured link to #{url}, found #{links.size}"
      assert_equal name.strip, links.first.text.strip

      para = links.first.parent
      assert_includes para.text, labels["featured_prefix"].strip
      assert_includes para.text, labels["featured_suffix"].strip

      body = panel.at_css(".panel-body").element_children
      assert_operator body.index(para), :>, body.index(panel.at_css(".panel-body > ul")),
        "#{lang}: the featured line renders above the hub list, not below it"

      hub_items = panel.css(".panel-body > ul > li a").map { |a| a["href"] }
      refute_includes hub_items, url, "#{lang}: the finder is still in the hub list as well"
    end
  end

  # French puts a space before a colon; the separator comes from the YAML so
  # composed headings follow the right convention on each page.
  def test_heading_separator_follows_each_language
    assert_equal ": ",  Wizard.text("en")["business"]["labels"]["heading_sep"]
    assert_equal " : ", Wizard.text("fr")["business"]["labels"]["heading_sep"]

    fr = Wizard.doc(Wizard::BUSINESS["fr"]).css("section.panel .panel-title").map { |h| h.text.strip }
    composed = fr.select { |h| h.include?(":") }
    refute_empty composed, "no composed headings on the French page to check"
    composed.each { |h| assert_includes h, " : ", "French heading missing the space before its colon: #{h}" }
  end

  # No English program name or URL may surface on a French page where the CSV
  # carries a French one.
  def test_french_page_shows_french_names_and_urls
    translated = Wizard::Expected.live("fr").reject do |r|
      r["name_fr"].to_s.strip.empty? || r["url_fr"].to_s.strip.empty?
    end
    shown = Wizard.all_programs(Wizard::BUSINESS["fr"])
    names = shown.map(&:first)
    urls  = shown.map(&:last)

    leaks = []
    translated.each do |r|
      leaks << "English name on the French page: #{r['program_name']}" if names.include?(r["program_name"].to_s.strip)
      leaks << "English URL on the French page: #{r['url_en']}" if urls.include?(r["url_en"].to_s.strip)
    end
    assert_empty leaks.uniq, leaks.uniq.join("\n  ")
  end
end
