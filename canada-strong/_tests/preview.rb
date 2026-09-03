#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Renders the canada-strong pages to a directory, using the same harness the
# tests use — so what you preview cannot drift from what the tests check.
#
#   ruby _tests/canada-strong/preview.rb out && (cd out && python3 -m http.server)
#
# A local server is required: the CDTS closure scripts do not run reliably
# from file://.

require_relative "support/wizard"

dir = ARGV[0] || "out"
Dir.mkdir(dir) unless Dir.exist?(dir)

Wizard::ALL_PAGES.each do |page|
  html, errors = Wizard.render_result(page)
  warn "  ! #{page}: #{errors.map(&:message).join('; ')}" if errors.any?
  File.write(File.join(dir, page), html)
  puts "  #{File.join(dir, page)}"
end
