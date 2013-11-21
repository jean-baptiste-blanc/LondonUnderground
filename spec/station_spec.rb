require_relative '../lib/station'

describe Station  do

	let(:station) {Station.new}

	context "should have" do
		it "a name" do
			station.name = "Northern Line"
			expect(station.name).to eq ("Northern Line")
		end

	end
	context "should know" do
		
		it "if it is opened" do
			station.is_opened = true
			expect(station.is_opened?).to be_true
		end

		it "if it is closed" do
			station.is_opened = false
			expect(station.is_opened?).to be_false
		end

	end

	context "should by default" do
		it "be opened" do
			expect(station.is_opened?).to be_true
		end
		
	end
end