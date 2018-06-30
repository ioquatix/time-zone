#!/usr/bin/env ruby

# https://bugs.ruby-lang.org/issues/14879
require 'time'

ENV['TZ'] = "Pacific/Auckland"
time = Time.parse("5pm")
ENV['TZ'] = "UTC"

puts time
puts time.utc_offset
puts (time + 1).utc_offset
puts time + 1
