# frozen_string_literal: true
#
# The French pages are the English ones with the language swapped, and the two
# YAML files are the same shape in two languages. Both drift the moment someone
# edits one side and forgets the other — which is exactly the failure the
# wizard's markdown warns about ("Keep them in step").

require "minitest/autorun"
require_relative "support/wizard"

class TestParity < Minitest::Test
  # Replace every English/French token with a placeholder, so two templates
  # that differ *only* by language normalise to the same bytes.
  def delang(src)
    src
      .gsub(/canada_strong_(en|fr)\b/, 'canada_strong_LANG')
      .gsub(/assign NAME = "(program_name|name_fr)"/, 'assign NAME = "LANG"')
      .gsub(/assign URLF = "(url_en|url_fr)"/, 'assign URLF = "LANG"')
      .gsub(/wet-(en|fr)\.js/, 'wet-LANG.js')
      .gsub(/(top|footer|preFooter|refTop|refFooter)-(en|fr)\.html/, '\1-LANG.html')
      .gsub(/(start|business)-(en|fr)\.html/, '\1-LANG.html')
      .gsub(/"lang":\s*"(en|fr)"/, '"lang": "LANG"')
  end

  def first_difference(a, b)
    al, bl = a.lines, b.lines
    idx = al.each_index.find { |i| al[i] != bl[i] }
    return "one file has #{al.size} lines, the other #{bl.size}" if idx.nil?
    "line #{idx + 1}:\n    en: #{al[idx].to_s.strip}\n    fr: #{bl[idx].to_s.strip}"
  end

  { "business" => Wizard::BUSINESS, "start" => Wizard::START }.each do |name, pages|
    define_method("test_#{name}_templates_differ_only_by_language") do
      en = delang(Wizard.source(pages["en"]))
      fr = delang(Wizard.source(pages["fr"]))
      assert_equal en, fr,
        "#{pages['en']} and #{pages['fr']} have drifted apart:\n  " + first_difference(en, fr)
    end
  end

  # ── The two YAML files ─────────────────────────────────────────────────
  def key_paths(node, prefix = "")
    case node
    when Hash  then node.flat_map { |k, v| ["#{prefix}#{k}"] + key_paths(v, "#{prefix}#{k}.") }
    when Array then node.each_with_index.flat_map { |v, i| key_paths(v, "#{prefix}#{i}.") }
    else []
    end
  end

  def test_the_two_yaml_files_have_the_same_shape
    en, fr = Wizard::LANGS.map { |l| key_paths(Wizard.text(l)).sort }
    assert_empty en - fr, "keys the English file has and the French one does not:\n  " + (en - fr).join("\n  ")
    assert_empty fr - en, "keys the French file has and the English one does not:\n  " + (fr - en).join("\n  ")
  end

  # The csv: values are identifiers. They stay English in the French file, or
  # the French page routes to nothing.
  %w[needs sectors regions].each do |group|
    define_method("test_#{group}_vocabulary_is_identical_in_both_files") do
      en, fr = Wizard::LANGS.map { |l| Wizard.text(l)[group].map { |e| [e["marker"], e["csv"]] } }
      assert_equal en, fr, "the #{group} bridge differs between en and fr; csv: values must stay English"
    end
  end

  def test_questions_ask_the_same_things_in_the_same_order
    en, fr = Wizard::LANGS.map do |l|
      Wizard.text(l)["business"]["questions"].map do |q|
        { "id" => q["id"], "next" => q["next"], "clears" => q["clears"].to_s.split(" ").sort,
          "markers" => q["options"].map { |o| o["marker"] } }
      end
    end
    assert_equal en, fr, "the question wiring differs between en and fr"
  end

  def test_start_page_offers_the_same_choices
    en, fr = Wizard::LANGS.map { |l| Wizard.text(l)["start"]["options"].size }
    assert_equal en, fr, "the start pages offer a different number of choices"
  end

  # Each language's internal links must stay inside that language.
  def test_internal_links_stay_in_their_language
    Wizard::LANGS.each do |lang|
      t = Wizard.text(lang)
      other = lang == "en" ? "fr" : "en"

      internal = t["start"]["options"].map { |o| o["href"] } + [t["business"]["back_href"]]
      internal.reject { |h| h.start_with?("http") }.each do |href|
        assert href.end_with?("-#{lang}.html"), "#{lang}: internal link #{href} leaves the language"
      end

      # Canada.ca links carry the language in the path.
      external = t["start"]["options"].map { |o| o["href"] } + t["breadcrumbs"].map { |b| b["href"] }
      external.select { |h| h.include?("canada.ca") }.each do |href|
        refute_includes href, "/#{other}/", "#{lang}: #{href} points at the #{other} site"
      end
    end
  end

  def test_both_files_carry_the_same_date_modified
    en, fr = Wizard::LANGS.map { |l| Wizard.text(l)["date_modified"] }
    assert_equal en, fr, "the two pages claim different last-modified dates"
  end

  def test_each_file_declares_its_own_language
    Wizard::LANGS.each { |l| assert_equal l, Wizard.text(l)["lang"], "canada_strong_#{l}.yml declares the wrong lang" }
    assert_equal "Français", Wizard.text("en")["alt_lang_text"]
    assert_equal "English",  Wizard.text("fr")["alt_lang_text"]
  end

  # Anything user-facing that is byte-identical in both files is either an
  # untranslated string or a proper noun. Worth a look either way.
  # Words that really are the same in both languages. Add to this list only
  # after checking the French, never to quiet the test.
  ALLOWED_IDENTICAL = [
    "Canada.ca",
    "Ontario",   # same in French
    "Prairies"   # "les Prairies" in French
  ].freeze

  def test_no_obviously_untranslated_interface_text
    en_q, fr_q = Wizard::LANGS.map { |l| Wizard.text(l)["business"]["questions"] }
    same = []
    en_q.each_with_index do |q, i|
      same << "question #{i + 1} legend" if q["legend"] == fr_q[i]["legend"]
      q["options"].each_with_index do |o, j|
        next unless o["label"] == fr_q[i]["options"][j]["label"]
        next if ALLOWED_IDENTICAL.include?(o["label"])
        same << "question #{i + 1} answer #{j + 1}: #{o['label'].inspect}"
      end
    end
    assert_empty same, "identical in both languages — untranslated?\n  " + same.join("\n  ")
  end
end
