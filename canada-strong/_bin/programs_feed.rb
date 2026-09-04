# frozen_string_literal: true
#
# The public shape of the routing table.
#
# _data/tariff_tool_links.json is the working file: it carries research prose,
# confidence grades and the deck's original labels, and it lives under an
# underscore so Jekyll never publishes it. This module derives the subset that
# is safe to serve — the programs themselves and the routing that decides who
# sees them — and nothing about how we researched them.
#
# The rule lives here rather than in the build script so that the test suite
# and the generator cannot disagree about what "public" means.

require "json"

module ProgramsFeed
  module_function

  # Fields that ship. Everything absent from this list is internal by default,
  # so a new field added to the working file stays private until someone adds
  # it here on purpose.
  PUBLIC_FIELDS = %w[need sector size region program_name name_fr org url_en url_fr].freeze

  # Withheld, and why each one is not merely untidy but genuinely internal:
  #   note        research prose — DM rulings, eligibility gaps, "the deck got
  #               this wrong". Never rendered, and never fit to be.
  #   slide_label what the original deck called a program, kept as the archival
  #               record of what the deck got wrong.
  #   fr_source   how each French name was sourced, including notes like "FAC's
  #               French page still carries an English title" and "brand site
  #               was down when checked" — our QA of other departments' pages.
  #   status      research confidence. `weak`, `best-guess`, `ambiguous` and
  #               `disputed` are our private judgements about government
  #               programs and would read as public grading of them.
  INTERNAL_FIELDS = %w[note slide_label fr_source status].freeze

  # Statuses that mean "this row is a marker, not a program". They exist so an
  # empty cell reads as checked rather than forgotten; their program_name is a
  # placeholder like "(route to sector-agnostic)". None of them renders on the
  # page, and none belongs in a feed of programs.
  NON_PROGRAM = %w[route no-page disputed].freeze

  # rows -> the public array, ordered exactly as the working file orders them,
  # because array order is display order.
  def build(rows)
    rows
      .reject { |r| NON_PROGRAM.include?(r["status"].to_s) }
      .map { |r| PUBLIC_FIELDS.to_h { |f| [f, r[f].to_s] } }
  end

  def render(rows)
    JSON.pretty_generate(build(rows)) + "\n"
  end
end
