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

RSpec.describe Time::Zone do
	let(:timezone) {"Pacific/Auckland"}
	let(:utc_offset) {43200}
	
	let(:now) {Time::Zone.now(timezone)}
	
	context '.new' do
		it "can compute specific time" do
			expect(Time::Zone.new(now.year, now.month, now.day, now.hour, now.min, now.sec, timezone)).to be_within(1).of(now)
		end
	end
	
	context '#utc_offset' do
		it "should have correct utc offset" do
			expect(now.utc_offset).to be >= utc_offset
		end
	end
	
	context '#utc' do
		it "can get current time" do
			expect(now.utc).to be_within(1).of(Time.now.utc)
		end
	end
	
	context '.convert' do
		let(:utc_time) {Time.now.utc}
		
		it "can convert times" do
			expect(utc_time.utc_offset).to be_zero
			
			local_time = Time::Zone.convert(utc_time, timezone)
			expect(local_time.utc_offset).to be >= utc_offset
		end
		
		it "won't convert localtime twice" do
			local_time = utc_local_time = nil
			
			Time::Zone.with("UTC") do
				utc_local_time = utc_time.localtime
			end
			
			Time::Zone.with(timezone) do
				local_time = utc_time.localtime
			end
			
			# This is an issue with Ruby.
			expect(local_time.utc_offset).to be == 0
		end
		
		it "can convert times which were already localtime" do
			# When times are converted, Ruby refuses to do further conversions.
			utc_local_time = Time::Zone.convert(utc_time, "UTC")
			
			local_time = Time::Zone.convert(utc_local_time, timezone)
			expect(local_time.utc_offset).to be >= utc_offset
		end
	end
	
	context '.parse' do
		# String doesn't include timezone information.
		it "can parse string including timezone" do
			time, zone = Time::Zone.parse(
				now.strftime("%c #{timezone}")
			)
			
			expect(time).to be_within(1).of(now)
			expect(zone).to be == timezone
		end
	end
end
