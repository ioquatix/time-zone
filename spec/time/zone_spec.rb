
RSpec.describe Time::Zone do
	let(:timezone) {"Pacific/Auckland"}
	let(:now) {Time::Zone.now(timezone)}
	
	it "should have correct utc offset" do
		expect(now.utc_offset).to be >= 43200
	end
	
	it "can get current time" do
		expect(now.utc).to be_within(5).of(Time.now.utc)
	end
	
	it "can convert times" do
		expect(Time::Zone.convert(Time.now.utc, timezone)).to be_within(1).of(now)
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
	# String doesn't include timezone information.
	let(:string) {now.strftime("%c")}
	
	it "can parse times" do
		expect(Time::Zone.parse(string, timezone)).to be_within(1).of(now)
	end
end
