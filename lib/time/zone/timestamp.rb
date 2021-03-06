# Copyright, 2018, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require_relative '../zone'

require 'date'

class Time
	module Zone
		class Timestamp
			include Comparable
			
			def self.load(string)
				self.parse(string)
			end
			
			def self.dump(time)
				time.strftime
			end
			
			def self.now(zone)
				self.from(Zone.now(zone), zone)
			end
			
			def self.from(time, zone)
				self.new(time.year, time.month, time.day, time.hour, time.minute, time.second, zone)
			end
			
			def self.parse(*args)
				self.from(*Zone.parse(*args))
			end
			
			def initialize(year, month, day, hour, minute, second, zone = "UTC")
				@year = year
				@month = month
				@day = day
				@hour = hour
				@minute = minute
				@second = second
				@zone = zone
				
				@time = nil
			end
			
			attr :year
			attr :month
			attr :day
			attr :hour
			attr :minute
			attr :second
			attr :zone
			
			def convert(zone)
				self.class.from(Time::Zone.convert(to_time, zone), zone)
			end
			
			# Generate a new time with the specified changes.
			# @param months [Numeric] add this many months
			# @param seconds [Numeric] add this many seconds
			# @param zone [String] forcefully change the timezone without doing any conversion.
			def with_offset(months = 0, seconds = 0, zone = @zone)
				current = self
				
				if months != 0
					current = current.to_datetime >> months
				end
				
				if seconds != 0
					# https://bugs.ruby-lang.org/issues/14879
					current = Time::Zone.convert(current.to_time + seconds, @zone)
				end
				
				self.class.from(current, zone)
			end
			
			# Add duration in various units.
			def offset_by(years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
				with_offset(
					years * 12 + months,
					(((weeks * 7 + days) * 24 + hours) * 60 + minutes) * 60 + seconds
				)
			end
			
			# Add duration in seconds.
			def + duration
				with_offset(0, duration)
			end
			
			# Return difference in seconds.
			def - other
				if other.is_a? Numeric
					# We are subtracting a duration:
					with_offset(0, -other)
				else
					to_time - other.to_time
				end
			end
			
			def to_time
				@time ||= Time::Zone.new(@year, @month, @day, @hour, @minute, @second, @zone).freeze
			end
			
			def to_date
				to_time.to_date
			end
			
			def to_datetime
				to_time.to_datetime
			end
			
			def iso8601
				to_time.iso8601
			end
			
			def <=> other
				to_time <=> other.to_time
			end
			
			DEFAULT_FORMAT = '%Y-%m-%d %H:%M:%S %Z'.freeze
			
			def to_s(format = relative_format)
				to_time.strftime(format.gsub('%Z', @zone))
			end
			
			def strftime(format = DEFAULT_FORMAT)
				to_s(format)
			end
			
			def relative_format(now = Timestamp.now(@zone))
				if self.year != now.year
					"%-l:%M%P, %B %-d, %Y, %Z"
				elsif self.month != now.month or self.day != now.day
					"%-l:%M%P, %B %-d, %Z"
				else
					"%-l:%M%P, %Z"
				end
			end
			
			alias to_str strftime
		end
	end
end
