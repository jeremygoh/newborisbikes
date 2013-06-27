require 'van'

describe Van do
let(:my_van){Van.new}	
	
	it "should have no bikes by default" do
		my_van.has_bikes?.should be_false
	end

context "Receiving a bike" do
	it "should receive bikes and have a bike" do
		station = double :station
		station.should_receive(:broken_bikes).and_return([:bike])
		station.should_receive(:release).and_return(:bike)
		my_van.receive_from_docking(station, 1)
		my_van.has_bikes?.should be_true
	end


	it "should not be able to receive a bike if at capacity" do
		station = double :station
		my_van.instance_eval('@bikes = [:bike, :bike, :bike, :bike, :bike, :bike, :bike, :bike, :bike, :bike]')
		my_van.receive_from_docking(station, 1).should eq "At maximum capacity. Can't receive anymore bikes!"
	end

	it "shouldn't be able to receive more bikes than are broken at the docking station" do
		station = double :station
		station.should_receive(:broken_bikes).and_return([])
		##how to say that station.broken_bikes.size should be 0?
		my_van.receive_from_docking(station, 1).should eq "There aren't enough broken bikes"
		my_van.has_bikes?.should be_false
	end

	


end

context "Delivering a bike to the garage for repair" do
	it "should deliver bikes to the garage and have one less broken bike" do
		bike = double :bike, broken?:true
		garage = double :garage
		station = double :station

		garage.should_receive(:receive)
		my_van.instance_eval('@bikes=[bike]')
		my_van.broken_bikes.size.should eq 1
		my_van.deliver(garage, 1)
		my_van.broken_bikes.size.should eq 0
	end

	it "should not be able to deliver a bike to the garage if it doesn't have enough" do
		my_van.deliver(:garage, 1).should eq "Not enough broken bikes to deliver!"
	end

	it "should be able to deliver multiple broken bikes to the garage and have that many less broken bikes" do
		bike = double :bike, broken?:true
		bike1 = double :bike, broken?:true
		bike2 = double :bike, broken?:true
		garage = double :garage
		garage.should_receive(:receive).twice
		my_van.instance_eval('@bikes=[bike,bike1,bike2]')
		my_van.broken_bikes.size.should eq 3
		my_van.deliver(garage, 2)
		my_van.broken_bikes.size.should eq 1
	end
end

context "Picking up a bike from a garage which has been repaired" do


	
	it "should pick up a working bike from the garage and have one more working bike" do
		garage = double :garage
		bike = double :bike, broken?:false
		my_van.should_receive(:capacity).and_return 10
		garage.should_receive(:release).and_return bike
		garage.should_receive(:working_bikes).and_return 1
		my_van.pick_up(garage, 1)
		my_van.working_bikes.size.should eq 1
	end

	it "should not be able to pick up more working bikes than the garage has" do
		garage = double garage
		garage.should_receive(:working_bikes).and_return [:bike]
		bike = double :bike, broken?:false
		my_van.pick_up(garage,3).should eq "Not enough working bikes to collect from the garage!"
	end

	it "should not be able to pick up anymore bikes from the garage if at maximum capacity." do
		my_van.should_receive(:capacity).and_return 0
		garage = double :garage
		garage.should_receive(:working_bikes).and_return [:bike]
		my_van.pick_up(garage, 1).should eq "At maximum capacity. Can't pick up anymore bikes."
	end

end

context "Returning a repaired bike to the docking station" do
	it "should be able to return a working bike to the docking station and have one less working bike" do
		van_with_working_bike = Van.new
		bike= double :bike, broken?: false
		station= double :station, full?:false
		station.should_receive(:receive)
		station.should_receive(:capacity).and_return 10
		van_with_working_bike.instance_eval('@bikes=[bike]')
		van_with_working_bike.return(station, 1)
		van_with_working_bike.working_bikes.size.should eq 0
	end

	it "should not be able to return a bike to a full station" do
		van_with_working_bike = Van.new
		bike= double :bike, broken?: false
		van_with_working_bike.instance_eval('@bikes=[bike]')
		station = double station
		station.should_receive(:capacity).and_return 0
		van_with_working_bike.return(station, 1)
		van_with_working_bike.working_bikes.size.should eq 1
	end

	it "should be able to return multiple bikes and have that many less working bikes" do
		van = Van.new
		bike= double :bike, broken?: false
		bike1= double :bike, broken?: false
		bike2= double :bike, broken?: false
		van.bikes = [bike, bike1, bike2]
		station= double :station, capacity:10
		station.should_receive(:receive).twice
		van.return(station, 2)
		van.working_bikes.size.should eq 1
	end

	it "should not be able to return multiple bikes if at any point, there will not be enough space in the docking station" do
		station = double :station, capacity:10
		station.should_receive(:capacity).and_return 1
		bike = double :bike, broken?: false
		bike1 = double :bike, broken?:false
		my_van.bikes=[bike,bike1]
		my_van.return(station,2).should eq "Not enough space in the dock to return that number of bikes!"
	end


	it "should not be able to return a bike if it has none" do
		station = double :station, capacity:10
		my_van.return(station, 1).should eq "Not enough working bikes to return!"
	end

end

end