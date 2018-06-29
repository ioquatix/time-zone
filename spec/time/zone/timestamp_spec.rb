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

require 'time/zone/timestamp'

RSpec.describe Time::Zone::Timestamp do
	let(:timezone) {"Pacific/Auckland"}
	let(:now) {Time::Zone::Timestamp.now(timezone)}
	
	let(:birthday) {Time::Zone::Timestamp.parse("12:20:30pm, 2nd April, 1985 Pacific/Auckland")}
	
	context '.parse' do
		it "can parse a string" do
			timestamp = described_class.parse("2018-04-02 15:14:15 Z")
			
			expect(timestamp.year).to be == 2018
			expect(timestamp.month).to be == 4
			expect(timestamp.day).to be == 2
			
			expect(timestamp.hour).to be == 15
			expect(timestamp.minute).to be == 14
			expect(timestamp.second).to be == 15
			
			expect(timestamp.zone).to be == "Z"
		end
		
		it "can parse a incomplete string" do
			timestamp = described_class.parse("May 25, 6pm")
			
			expect(timestamp.month).to be == 5
			expect(timestamp.day).to be == 25
			expect(timestamp.hour).to be == 12+6
		end
	end
	
	context '#-' do
		it "can subtract a duration" do
			time = birthday - 90
			
			expect(time.minute).to be == (birthday.minute - 1)
			expect(time.second).to be == (birthday.second - 30)
		end
		
		it "can subtract two timestamps" do
			duration = now - birthday
			
			# I was older than 30 when I wrote this test :)
			expect(duration).to be > (30*365*24*60*60)
		end
	end
	
	context '#iso8601' do
		it "generates valid string" do
			expect(now.iso8601).to be =~ /\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\+\d{2}:\d{2}/
		end
	end
	
	context '#stftime' do
		it "generates valid string according to default format" do
			expect(birthday.strftime).to be == "1985-04-02 12:20:30 Pacific/Auckland"
		end
	end
end
