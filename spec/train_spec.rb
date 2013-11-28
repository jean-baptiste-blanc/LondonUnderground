require_relative '../lib/train'

describe Train  do

	let(:train) {Train.new}
	let(:line) {Line.new}
	let(:station) {Station.new}
	let(:tunnel) {Tunnel.new}



	context "should have" do

		it "a capacity" do
			train.capacity = 100
			expect(train.capacity).to eq(100)
		end

		it "a direction" do
			create_line
			train.toward = line.last_station
			expect(train.toward.name).to eq ('Angel')
			train.toward = line.first_station
			expect(train.toward.name).to eq ('Bank')	
		end
	end
	context "should know" do
		it "if it is operational" do
			train.is_operational = true
			expect(train.is_operational?).to be_true
		end

		it "if it is operational" do
			train.is_operational = false
			expect(train.is_operational?).to be_false
		end

		it "it's current location" do
			station.name ="Bank"
			train.is_at = station
			expect(train.is_at.name).to eq("Bank")
		end

		it "it's last station" do
			station.name = "Bank"
			train.was_at = station
			expect(train.was_at.name).to eq("Bank")
		end

		it "it's current location could be a tunnel" do
			station.name ="Bank"
			tunnel.name = "Bank-Moorgate"
			station.add(tunnel)
			train.is_at = station.tunnels.first
			expect(train.is_at.name).to eq("Bank-Moorgate")
		end

		it "how to move to the next location from station " do
			create_line
			create_tunnels
			train.is_at = line.first_station
			train.move(line,line.last_station)
			expect(train.is_at.name).to eq("Bank-Moorgate")
		end

		it "how to move to the next location from tunnel " do
			create_line
			create_tunnels
			train.is_at = line.first_station
			train.move(line,line.last_station)
			train.move(line,line.last_station)
			expect(train.is_at.name).to eq("Moorgate")
		end
	end

	context "should by default" do
		it "be opened" do
			expect(train.is_operational?).to be_true
		end

		
	end

	def create_line
		station_names =["Bank","Moorgate","Old Street","Angel"]
		station_names.each do|station_name|
			station = Station.new
			station.name = station_name
			line.add(station)
		end
	end
	def create_tunnels
		toward = line.last_station
		line.stations.each do |station| 
			line.create_tunnel(station,line.next_station(station,station,toward)) 
		end
	end
end