#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Regenerates canada-strong/programs.json from _data/tariff_tool_links.json.
#
#   ruby _bin/build-programs-json.rb   (run from canada-strong/)
#
# The output is committed rather than generated at build time: this site runs
# on GitHub Pages, which will not run custom Jekyll plugins. test_public_feed.rb
# fails if the committed file and this script disagree, so a data edit that
# forgets to re-run this is caught before it ships, not after.

require "json"
require_relative "programs_feed"

root   = File.expand_path("..", __dir__)
source = File.join(root, "_data", "tariff_tool_links.json")
target = File.join(root, "programs.json")

rows = JSON.parse(File.read(source))
out  = ProgramsFeed.render(rows)

changed = !File.exist?(target) || File.read(target) != out
File.write(target, out)

puts "#{File.basename(target)}: #{ProgramsFeed.build(rows).size} of #{rows.size} rows, " \
     "#{ProgramsFeed::PUBLIC_FIELDS.size} of #{rows.first.keys.size} fields " \
     "(#{changed ? 'updated' : 'already current'})"
