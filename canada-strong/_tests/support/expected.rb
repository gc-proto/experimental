# frozen_string_literal: true
#
# The expected side of the routing test: what _data/tariff_tool_links.csv says
# a combination of answers should return, worked out straight from the CSV.
#
# This is deliberately a second implementation of the rules the wizard's
# markdown describes, not a call into the template. If it just asked the
# template what it thought, it would agree with every bug.

require_relative "wizard"

module Wizard
  module Expected
    module_function

    # Rows that survive `exclude_statuses`. Those statuses are the CSV's way of
    # saying "researched, and it does not belong on the page".
    def live(lang = "en")
      excluded = Wizard.text(lang)["exclude_statuses"].to_s.split(" ")
      Wizard.rows.reject { |r| excluded.include?(r["status"].to_s) }
    end

    # A row's need column may carry several needs, semicolon separated.
    def needs_of(row)
      row["need"].to_s.split(";").map(&:strip)
    end

    def need?(row, need_csv)
      needs_of(row).include?(need_csv)
    end

    # What the user actually sees for a row, per language, with the documented
    # fallback to the English column when the French one is blank.
    def display(row, lang)
      cols = Wizard::COLUMNS[lang]
      name = row[cols[:name]].to_s.strip
      name = row["program_name"].to_s.strip if name.empty?
      url  = row[cols[:url]].to_s.strip
      url  = row["url_en"].to_s.strip if url.empty?
      [name, url]
    end

    # ── The four groups of rows a page is built from ───────────────────────

    # The sector cell: national rows for this sector and need, minus the
    # `route` markers, which stand for "no stream here" and render as a note.
    def sector_cell(need_csv, sector_csv, lang = "en")
      return [] unless sector_csv
      live(lang).select do |r|
        r["region"] == "national" && r["sector"] == sector_csv &&
          need?(r, need_csv) && r["status"] != "route"
      end
    end

    def agnostic_column(need_csv, lang = "en")
      live(lang).select do |r|
        r["region"] == "national" && r["sector"] == "sector-agnostic" && need?(r, need_csv)
      end
    end

    def regional(need_csv, region_csvs, lang = "en")
      live(lang).select { |r| region_csvs.include?(r["region"]) && need?(r, need_csv) }
    end

    def sector_hub(sector_csv, lang = "en")
      return [] unless sector_csv
      live(lang).select { |r| r["need"] == "all" && r["sector"] == sector_csv }
    end

    def agnostic_hubs(lang = "en")
      live(lang).select { |r| r["need"] == "all" && r["sector"] == "sector-agnostic" }
    end

    # ── One combination ────────────────────────────────────────────────────

    # True when the sector cell has no dedicated stream — the sector-specific
    # panel is omitted entirely rather than shown with a "no stream" note; the
    # business still sees the sector-agnostic results for that need.
    def no_sector_stream?(need_csv, sector_csv, lang = "en")
      !sector_csv.nil? && sector_cell(need_csv, sector_csv, lang).empty?
    end

    # Every program that should be visible, in no particular order.
    def programs(lang, need_marker, region_marker, sector_marker)
      need_csv   = Wizard.need_csv(lang, need_marker)
      sec_csv    = Wizard.sector_csv(lang, sector_marker)
      reg_csvs   = Wizard.region_csvs(lang, region_marker)

      rows = sector_cell(need_csv, sec_csv, lang) +
             sector_hub(sec_csv, lang) +
             agnostic_column(need_csv, lang) +
             regional(need_csv, reg_csvs, lang) +
             agnostic_hubs(lang)

      rows.map { |r| display(r, lang) }
    end
  end
end
