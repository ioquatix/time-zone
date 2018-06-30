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

require_relative 'zone/version'

require_relative 'zone/locking'

require 'time'

class Time
	alias minute min
	alias second sec
	
	module Zone
		def self.new(year, month, day, hour, minute, second, zone)
			with(zone) do
				return Time.new(year, month, day, hour, minute, second).localtime
			end
		end
		
		def self.now(zone)
			with(zone) do
				# Time instances are lazy initialized, so we need to force it to pick up the current TZ by invoking #localtime
				return Time.new.localtime
			end
		end
		
		def self.convert(time, zone)
			with(zone) do
				return Time.new(time.year, time.month, time.day, time.hour, time.minute, time.second, time.utc_offset).localtime
			end
		end
		
		def self.parse(string, zone = "UTC", *args)
			string = string.dup
			
			if string.sub!(/\s([a-zA-Z][\w]*(\/[\w]+)?)$/, "")
				zone = $1
			end
			
			with(zone) do
				return Time.parse(string, *args).localtime, zone
			end
		end
	end
end
