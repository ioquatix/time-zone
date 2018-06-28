
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
	
	# String doesn't include timezone information.
	let(:string) {now.strftime("%c")}
	
	it "can parse times" do
		expect(Time::Zone.parse(string, timezone)).to be_within(1).of(now)
	end
end
