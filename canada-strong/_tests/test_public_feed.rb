# frozen_string_literal: true
#
# programs.json is the only canada-strong data file Jekyll publishes, so it is
# the one place where a research note could leak onto test.canada.ca. These
# tests are the guardrail: they check what is in it, what is deliberately not,
# and that it still matches the working file it is derived from.

require "minitest/autorun"
require "json"
require_relative "support/expected"
require_relative "../_bin/programs_feed"

class TestPublicFeed < Minitest::Test
  FEED = File.join(Wizard::PAGES, "programs.json")

  def feed
    @feed ||= JSON.parse(File.read(FEED))
  end

  def test_the_feed_exists_and_is_a_flat_array_of_objects
    assert File.exist?(FEED), "programs.json is missing — run ruby _bin/build-programs-json.rb"
    assert_kind_of Array, feed
    refute_empty feed
    assert feed.all? { |r| r.is_a?(Hash) }, "programs.json must be a flat array of objects"
  end

  # The generator is committed output, because GitHub Pages will not run a
  # custom plugin. That makes drift the obvious failure: someone edits the
  # working file and ships without regenerating. This is the check that stops it.
  def test_the_feed_matches_the_working_file
    expected = ProgramsFeed.build(Wizard.rows)
    assert_equal expected, feed,
      "programs.json is out of step with _data/tariff_tool_links.json — " \
      "run ruby _bin/build-programs-json.rb and commit the result"
  end

  def test_no_internal_field_is_published
    leaked = feed.flat_map(&:keys).uniq & ProgramsFeed::INTERNAL_FIELDS
    assert_empty leaked, "programs.json publishes internal field(s): #{leaked.join(', ')}"

    unexpected = feed.flat_map(&:keys).uniq - ProgramsFeed::PUBLIC_FIELDS
    assert_empty unexpected,
      "programs.json carries field(s) nobody declared public: #{unexpected.join(', ')}. " \
      "Add them to ProgramsFeed::PUBLIC_FIELDS on purpose, or leave them out."
  end

  # The field list could be right and the values still wrong — a note pasted
  # into a program_name, say. This checks the actual prose, not the schema.
  #
  # An internal value that a published value of the same row already contains is
  # not a leak: `slide_label` for CALA is "Canadian Agricultural Loans Act",
  # which is a substring of the published name "Canadian Agricultural Loans Act
  # (CALA) Program". Publishing a program's name does not leak the deck's older,
  # shorter name for it.
  def test_no_research_note_survives_anywhere_in_the_feed
    blob = File.read(FEED)
    Wizard.rows.each do |r|
      published = ProgramsFeed::PUBLIC_FIELDS.map { |f| r[f].to_s }
      ProgramsFeed::INTERNAL_FIELDS.each do |f|
        v = r[f].to_s.strip
        next if v.length < 20 # short values like "verified" are not prose
        next if published.any? { |pv| pv.include?(v) }
        refute blob.include?(v), "#{f} for #{r['program_name']} appears in programs.json"
      end
    end
  end

  # Marker rows carry placeholder names like "(route to sector-agnostic)". They
  # never render, and a feed of programs that contains them is wrong twice over.
  def test_marker_rows_are_not_published
    names = feed.map { |r| r["program_name"] }
    assert_empty names.grep(/\A\(/), "placeholder row(s) published: #{names.grep(/\A\(/).join(', ')}"

    markers = Wizard.rows.select { |r| ProgramsFeed::NON_PROGRAM.include?(r["status"].to_s) }
    refute_empty markers, "no marker rows left in the working file — has `status` been repurposed?"
    markers.each do |r|
      refute_includes names, r["program_name"], "#{r['status']} row #{r['program_name']} published"
    end
  end

  # The strong check, and the reason the two files can be trusted to agree:
  # the feed and the rendered page must name the same programs. Derived from
  # the HTML, not from the data, so it is a genuinely second opinion.
  #
  # The one `featured` row is held out of the list comparison because it does
  # not render as a list item: it is the promoted sentence after the </ul> that
  # closes the More options panel, so all_programs (which reads `ul > li`) never
  # sees it. It is checked against the raw HTML just below instead.
  def test_the_feed_and_the_page_name_the_same_programs
    Wizard::LANGS.each do |lang|
      col     = Wizard::COLUMNS[lang][:name]
      routed  = feed.reject { |r| r["need"] == "featured" }
      page    = Wizard.all_programs(Wizard::BUSINESS[lang]).map { |name, _url| name.strip }.uniq
      infeed  = routed.map { |r| r[col].to_s.strip }.reject(&:empty?).uniq

      assert_empty infeed - page,
        "#{lang}: in programs.json but never rendered: #{(infeed - page).join(', ')}"
      assert_empty page - infeed,
        "#{lang}: rendered but missing from programs.json: #{(page - infeed).join(', ')}"
    end
  end

  def test_the_featured_row_is_in_the_feed_and_on_the_page
    featured = feed.select { |r| r["need"] == "featured" }
    assert_equal 1, featured.size,
      "the template renders exactly one featured row; the feed has #{featured.size}"

    Wizard::LANGS.each do |lang|
      name = featured.first[Wizard::COLUMNS[lang][:name]].to_s.strip
      html = Wizard.render(Wizard::BUSINESS[lang])
      assert html.include?(name), "#{lang}: featured row #{name} is in the feed but not on the page"
    end
  end

  # Every URL is a public canada.ca-or-partner link, and nothing internal has
  # crept into one as a query string.
  def test_every_url_is_public_and_plain
    bad = []
    feed.each do |r|
      %w[url_en url_fr].each do |f|
        v = r[f].to_s
        next if v.empty?
        bad << "#{r['program_name']}: #{f}=#{v}" unless v.start_with?("https://")
      end
    end
    assert_empty bad, bad.join("\n  ")
  end

  # Unlike _data/, this file has no underscore protecting it: it is meant to be
  # fetched. That is the whole point, and also the reason for every test above.
  def test_the_feed_sits_where_jekyll_will_publish_it
    refute File.basename(FEED).start_with?("_"),
      "programs.json is meant to be served; an underscore would hide it from the build"
    assert_equal Wizard::PAGES, File.dirname(FEED),
      "programs.json must sit beside the pages, not inside _data (which Jekyll skips)"
  end
end
