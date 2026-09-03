#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Runs every canada-strong test in one process.
#   ruby _tests/run.rb   (run from canada-strong/)

require "minitest/autorun"
Dir[File.join(__dir__, "test_*.rb")].sort.each { |f| require f }
