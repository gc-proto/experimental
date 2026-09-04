# frozen_string_literal: true
#
# Shared harness for the Canada Strong tariff-tool tests.
#
# Renders the four canada-strong templates the way Jekyll does — same _data,
# same Liquid, same two Jekyll-only array filters — so the tests see the bytes
# that ship to test.canada.ca. Nothing here knows what the answer *should* be;
# the expected side is rebuilt from the CSV in `expected.rb`.

require "csv"
require "yaml"
require "nokogiri"

begin
  require "liquid"
rescue LoadError
  # liquid is a --user-install gem on the team's machines, not in the Gemfile.
  $LOAD_PATH.unshift(*Dir[File.expand_path("~/.gem/ruby/*/gems/liquid-*/lib")])
  require "liquid"
end

module Wizard
  # Anchored to this folder, not to the repo, so the suite still runs if
  # canada-strong is copied somewhere else to be worked on.
  PAGES  = File.expand_path("../..", __dir__)
  ROOT   = File.expand_path("..", PAGES)
  CONFIG = File.join(ROOT, "_config.yml")

  # Where the program data lives. Inside the Jekyll repo this comes out of
  # _config.yml, so the tests follow the real build rather than asserting a
  # parallel truth. Outside it — a copy of just this folder — fall back to the
  # folder's own _data, which is where the files sit anyway.
  def self.config
    @config ||= File.exist?(CONFIG) ? (YAML.load_file(CONFIG) || {}) : nil
  end

  def self.data_dir
    @data_dir ||= if config && config["data_dir"]
                    File.join(ROOT, config["data_dir"])
                  else
                    File.join(PAGES, "_data")
                  end
  end

  LANGS = %w[en fr].freeze
  BUSINESS = { "en" => "business-en.html", "fr" => "business-fr.html" }.freeze
  START    = { "en" => "start-en.html",    "fr" => "start-fr.html" }.freeze
  ALL_PAGES = (BUSINESS.values + START.values).freeze

  # Which CSV columns each language reads, and what it falls back to when the
  # column is blank. The fallback is deliberate: a missing French name shows
  # the English one so the gap is visible rather than silent.
  COLUMNS = {
    "en" => { name: "program_name", url: "url_en" },
    "fr" => { name: "name_fr",      url: "url_fr" }
  }.freeze

  # ── Jekyll's array filters, which the bare liquid gem does not ship ────────
  module JekyllishFilters
    def where(input, prop, value)
      return input unless input.respond_to?(:select)
      input.select { |i| i.is_a?(Hash) && i[prop].to_s == value.to_s }
    end

    def where_exp(input, var, expr)
      return input unless input.respond_to?(:select)
      tmpl = Liquid::Template.parse("{% if #{expr} %}1{% endif %}")
      input.select do |i|
        @context.stack { @context[var] = i; tmpl.render(@context).strip == "1" }
      end
    end
  end
  Liquid::Template.register_filter(JekyllishFilters)

  class << self
    # ── Site data, loaded as Jekyll loads _data ─────────────────────────────
    def site_data
      @site_data ||= begin
        d = {}
        Dir[File.join(data_dir, "*.yml")].each { |f| d[File.basename(f, ".yml")] = YAML.load_file(f) }
        Dir[File.join(data_dir, "*.csv")].each { |f| d[File.basename(f, ".csv")] = CSV.read(f, headers: true).map(&:to_h) }
        d
      end
    end

    def rows
      site_data["tariff_tool_links"]
    end

    # Interface text for a language: site.data.canada_strong_en / _fr
    def text(lang)
      site_data["canada_strong_#{lang}"]
    end

    # ── Templates ──────────────────────────────────────────────────────────
    def source(page)
      File.read(File.join(PAGES, page))
    end

    # Front matter off, exactly as Jekyll strips it before running Liquid.
    def body(page)
      source(page).sub(/\A---\s*\n.*?\n---\s*\n/m, "")
    end

    def front_matter(page)
      m = source(page).match(/\A---\s*\n(.*?)\n---\s*\n/m)
      m && YAML.safe_load(m[1])
    end

    # [rendered html, liquid errors]
    def render_result(page)
      @render_result ||= {}
      @render_result[page] ||= begin
        tmpl = Liquid::Template.parse(body(page))
        out  = tmpl.render("site" => { "data" => site_data })
        [out, tmpl.errors]
      end
    end

    def render(page)
      render_result(page).first
    end

    def doc(page)
      @doc ||= {}
      @doc[page] ||= Nokogiri::HTML(render(page))
    end

    # ── The generated stylesheet is the routing ────────────────────────────
    # Every rule the template generates has the shape
    #   #wz-state.need-liq.sec-agri .wz-p-liquidity-agriculture { display: block; }
    # i.e. a set of required answer markers, and the one class it reveals.
    RULE = /\#wz-state((?:\.[A-Za-z0-9_-]+)*)\s+\.([A-Za-z0-9_-]+)\s*\{\s*display:\s*([a-z-]+)\s*;?\s*\}/.freeze

    def stylesheet(page)
      doc(page).css("head style").map(&:text).join("\n")
    end

    def rules(page)
      @rules ||= {}
      @rules[page] ||= stylesheet(page).scan(RULE).map do |state, target, display|
        { markers: state.split(".").reject(&:empty?), target: target, display: display }
      end
    end

    # Classes revealed when #wz-state carries exactly these markers.
    def visible_targets(page, markers)
      m = Array(markers)
      rules(page).select { |r| (r[:markers] - m).empty? }.map { |r| r[:target] }.uniq
    end

    # ── Reading the rendered page back ─────────────────────────────────────
    def shown?(node, visible)
      cls = node["class"].to_s.split
      conditional = cls.include?("wz-r") || cls.include?("wz-rb") || cls.include?("wz-sz")
      !conditional || (cls & visible).any?
    end

    def visible_panels(page, markers)
      visible = visible_targets(page, markers)
      doc(page).css("section.panel").select { |s| shown?(s, visible) }
    end

    # Programs listed in one panel, as [name, url] pairs. Pass `visible` to
    # also drop individual rows a CSV `size` column hides for this set of
    # markers (e.g. LETL under a non-large size); omit it to get every row
    # regardless of visibility, for DOM-wide leak checks.
    # A link's visible text. Result links carry a new-tab arrow and a wb-inv
    # sentence saying so, both inside the <a>; neither is part of the program's
    # name, so both come off before the text is read.
    def link_text(link)
      copy = link.dup
      copy.css("span.wb-inv, svg").remove
      copy.text.strip
    end

    def panel_programs(panel, visible = nil)
      items = panel.css(".panel-body > ul > li")
      items = items.select { |li| shown?(li, visible) } if visible
      items.map do |li|
        link = li.at_css("a")
        if link
          [link_text(link), link["href"].to_s.strip]
        else
          copy = li.dup
          copy.css("span.wz-org").remove
          [copy.text.strip, ""]
        end
      end
    end

    # Every program visible for one set of answers, across every shown panel.
    def visible_programs(page, markers)
      visible = visible_targets(page, markers)
      visible_panels(page, markers).flat_map { |p| panel_programs(p, visible) }
    end

    # Every program in the DOM, visible or not. Used to check that rows the
    # CSV excludes were never written out in the first place.
    def all_programs(page)
      @all_programs ||= {}
      @all_programs[page] ||= doc(page).css("section.panel").flat_map { |p| panel_programs(p) }
    end

    # ── The answer vocabulary, read off the YAML ───────────────────────────
    def question(lang, id)
      text(lang)["business"]["questions"].find { |q| q["id"] == id }
    end

    def markers_for(lang, question_id)
      question(lang, question_id)["options"].map { |o| o["marker"] }
    end

    def need_markers(lang)   markers_for(lang, "question-1") end
    def region_markers(lang) markers_for(lang, "question-2") end
    def size_markers(lang)   markers_for(lang, "question-3") end
    def sector_markers(lang) markers_for(lang, "question-4") end

    # marker -> the CSV value(s) it stands for. Sector answers with no CSV
    # sector of their own (manufacturing, U.S. exporter) map to nil on purpose.
    # Q1's "All of the above" answer. Not a need, so `needs:` does not carry it
    # and need_csv returns nil for it — callers branch on this instead.
    def all_needs_marker(lang)
      text(lang)["all_needs_marker"]
    end

    def all_needs?(lang, marker)
      marker == all_needs_marker(lang)
    end

    def need_csv(lang, marker)
      e = text(lang)["needs"].find { |n| n["marker"] == marker }
      e && e["csv"]
    end

    def sector_csv(lang, marker)
      e = text(lang)["sectors"].find { |s| s["marker"] == marker }
      e && e["csv"]
    end

    def region_csvs(lang, marker)
      e = text(lang)["regions"].find { |r| r["marker"] == marker }
      e ? e["csv"].split(";") : []
    end

    # Most rows have no size column and show for every size; size_csv is what
    # the rare row that restricts itself (e.g. LETL, size: large) is checked
    # against.
    def size_csv(lang, marker)
      e = text(lang)["sizes"].find { |s| s["marker"] == marker }
      e && e["csv"]
    end

    # All 140 need x region x sector combinations (the routing dimensions).
    def combinations(lang)
      need_markers(lang).flat_map do |n|
        region_markers(lang).flat_map do |r|
          sector_markers(lang).map { |s| { need: n, region: r, sector: s } }
        end
      end
    end

    # The above, crossed with every size answer too — 700 total. Used where a
    # test needs to check that a size-gated CSV row (like LETL) behaves
    # correctly everywhere it could appear, not just at one fixed size.
    def combinations_with_size(lang)
      combinations(lang).flat_map do |c|
        size_markers(lang).map { |sz| c.merge(size: sz) }
      end
    end
  end
end
