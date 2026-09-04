# frozen_string_literal: true
#
# canada-strong is meant to stand alone: someone can take the folder, work on
# it, and it carries its own copy, its own program data and its own tests.
#
# The load-bearing part of that is `data_dir` in _config.yml. Jekyll allows one
# data directory site-wide, and it points into this folder. Break the link and
# every page still builds — it just builds empty, with no questions and no
# programs, which is the worst way for this to fail.

require "minitest/autorun"
require_relative "support/wizard"

class TestStandalone < Minitest::Test
  # Outside the Jekyll repo there is no _config.yml to check; the harness falls
  # back to this folder's own _data and the rest of the suite still applies.
  def config
    Wizard.config or skip("no _config.yml — running from a copy of the folder alone")
  end

  def test_config_points_its_data_dir_into_this_folder
    dir = config["data_dir"]
    refute_nil dir, "_config.yml has no data_dir, so Jekyll would look in the repo-root _data"
    assert dir.start_with?("canada-strong/"),
      "data_dir is #{dir.inspect}; canada-strong's data must live inside canada-strong"
    assert Dir.exist?(Wizard.data_dir), "data_dir points at #{dir}, which does not exist"
  end

  # The `note` field is an internal research scratchpad — the wizard's
  # markdown says say anything you like in it. Jekyll copies any folder it can
  # see into the built site, so a data folder without the leading underscore
  # would publish those notes as a fetchable JSON file on test.canada.ca.
  def test_the_data_folder_is_not_published
    dir = config["data_dir"]
    assert File.basename(dir).start_with?("_"),
      "#{dir} would be copied into the built site, publishing the internal `note` field. " \
      "Jekyll skips entries starting with an underscore."
  end

  def test_every_data_file_the_pages_need_is_present
    %w[canada_strong_en.yml canada_strong_fr.yml tariff_tool_links.json].each do |f|
      assert File.exist?(File.join(Wizard.data_dir, f)),
        "#{f} is missing from #{config['data_dir']}"
    end
  end

  # Whatever the templates ask site.data for must actually be there. This is
  # the check that catches a move like this one going wrong: Liquid renders a
  # missing key as empty string rather than failing.
  def test_every_site_data_key_the_templates_use_resolves
    missing = []
    Wizard::ALL_PAGES.each do |page|
      Wizard.source(page).scan(/site\.data\.([a-zA-Z0-9_]+)/).flatten.uniq.each do |key|
        next if Wizard.site_data.key?(key)
        missing << "#{page} reads site.data.#{key}, which is not in #{config['data_dir']}"
      end
    end
    assert_empty missing, missing.join("\n  ")
  end

  # An empty build is the failure mode this whole file exists to catch, so
  # assert the pages came out populated rather than merely well-formed.
  Wizard::LANGS.each do |lang|
    define_method("test_the_rendered_page_is_not_empty_#{lang}") do
      page = Wizard::BUSINESS[lang]
      doc  = Wizard.doc(page)

      assert_equal 4, doc.css("[id^=question-]").size, "#{lang}: the questions did not render"
      refute_empty doc.at_css("h1").text.strip, "#{lang}: the h1 is empty"
      assert Wizard.all_programs(page).size > 40,
        "#{lang}: only #{Wizard.all_programs(page).size} programs rendered — the program data did not load"
      refute_empty Wizard.rules(page), "#{lang}: no routing rules were generated"
    end
  end

  # The folder has to be self-contained: nothing in it may reach back out into
  # the repo for content.
  def test_the_pages_do_not_reach_outside_the_folder
    strays = []
    Wizard::ALL_PAGES.each do |page|
      src = Wizard.source(page)
      src.scan(/\{%-?\s*include\s+(\S+)/).flatten.each { |i| strays << "#{page} includes #{i}" }
      strays << "#{page} sets a layout, which lives outside this folder" if Wizard.front_matter(page)["layout"]
    end
    assert_empty strays, strays.join("\n  ")
  end

  # The build that ships is GitHub Pages, and it runs Liquid over the folder's
  # renderable files before Markdown ever sees them — fenced code blocks do not
  # protect anything. how-this-wizard-works.md documents this template's Liquid,
  # so it necessarily contains tags written to be read rather than executed; one
  # of them failed to parse, took the whole Pages build down with "Syntax Error
  # in 'for loop'", and left test.canada.ca on a stale build for five hours. The
  # fix was to exclude the file in _config.yml, and this is the guard on it: a
  # file in this folder either parses as Liquid or is excluded from the build.
  # Nothing here can catch it at commit time except a check like this, because
  # the suite deliberately renders without Jekyll.
  def test_every_file_the_build_reads_parses_as_liquid
    require "liquid"
    excluded = Array(config["exclude"])
    unparseable = []

    Dir.glob(File.join(Wizard::PAGES, "**", "*.{html,md,markdown}")).sort.each do |path|
      rel = path.sub(%r{\A#{Regexp.escape(File.dirname(Wizard::PAGES))}/}, "")
      next if rel.split("/").any? { |seg| seg.start_with?("_") || seg == "out" }
      next if excluded.any? { |e| rel == e || rel.start_with?(e.chomp("/") + "/") }

      begin
        Liquid::Template.parse(File.read(path))
      rescue Liquid::Error => e
        unparseable << "#{rel}: #{e.message}"
      end
    end

    assert_empty unparseable,
      "these would fail the Pages build; fix the Liquid or add the file to `exclude` in _config.yml:\n  " +
      unparseable.join("\n  ")
  end

  # Excluding a file only helps while the exclusion is actually there, and
  # `exclude` REPLACES Jekyll's defaults rather than adding to them — so the
  # list has to keep restating them. Both halves are pinned.
  def test_the_liquid_documentation_stays_out_of_the_build
    excluded = Array(config["exclude"])
    assert_includes excluded, "canada-strong/how-this-wizard-works.md",
      "the wizard's own documentation is full of Liquid written to be read, not run; " \
      "in the build it is a syntax error that takes the whole site down"
    %w[Gemfile Gemfile.lock vendor/bundle/ node_modules/].each do |default|
      assert_includes excluded, default,
        "`exclude` replaces Jekyll's defaults; dropping #{default} starts publishing it"
    end
  end

  # Everything needed to work on this prototype should be in the one folder.
  def test_the_folder_carries_its_own_docs_data_and_tests
    %w[
      how-this-wizard-works.md
      _data/tariff_tool_links.json
      programs.json _bin/programs_feed.rb _bin/build-programs-json.rb
      business-en.html business-fr.html start-en.html start-fr.html
    ].each do |f|
      assert File.exist?(File.join(Wizard::PAGES, f)), "canada-strong/#{f} is missing"
    end
  end
end
