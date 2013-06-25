require 'van'

describe Van do
let(:my_van){Van.new}	
	
	it "should have no bikes by default" do
		my_van.has_bikes?.should be_false
	end

	it "should receive bikes and have a bike" do
		bike = double :bike, broken?:true
		my_van.receive_from_docking(bike)
		my_van.has_bikes?.should be_true
	end

	it "should not be able to receive a working bike" do
		bike = double :bike, broken?: false
		my_van.receive_from_docking(bike).should eq "Can't receive a working bike!"
	end

	it "should not be able to receive a bike if at capacity" do
		bike = double :bike, broken?: true
		10.times{my_van.receive_from_docking(bike)}
		my_van.receive_from_docking(bike).should eq "At maximum capacity. Can't receive anymore bikes!"
	end

	it "should deliver bikes to the garage and have one less broken bike" do
		bike = double :bike, broken?:true
		my_van.receive_from_docking(bike)
		my_van.broken_bikes.size.should eq 1
		
	end

	it "should not be able to deliver a bike to the garage if it has none" do
		my_van.deliver(:bike).should eq "No bikes to deliver."
	end

	it "should not be able to deliver a working bike to the garage" do
		bike = double :bike, broken?: false
		my_van.pick_up(bike)
		my_van.deliver(bike).should eq "Can't deliver a working bike to the garage!"
	end

	it "should not be able to pick up a broken bike from the garage" do
		bike = double :bike, broken?:true
		my_van.pick_up(bike).should eq "Can't pick up bike as it hasn't been repaired yet."
	end

	
	it "should pick up a working bike from the garage and have one more working bike" do
		bike = double :bike, broken?: false
		my_van.pick_up(bike)
		
		my_van.working_bikes.size.should eq 1
	end

	it "should not be able to pick up anymore bikes from the garage if at maximum capacity." do
		bike = double :bike, broken?: false
		10.times{my_van.pick_up(bike)}
		my_van.pick_up(bike).should eq "At maximum capacity. Can't pick up anymore bikes."
	end

	it "should be able to return a working bike to the docking station and have one less working bike" do
		bike = double :bike, broken?: false
		my_van.return(bike)
		my_van.working_bikes.size.should eq 0
	end

	it "should not be able to return a broken bike" do
		bike = double :bike, broken?: true
		my_van.receive_from_docking(bike)
		my_van.return(bike).should eq "Can't return a broken bike to the docking station!"
	end
	#it "should return bikes to the docking station and have one less working bike" do

	it "should not be able to return a bike if it has none" do
		my_van.return(:bike).should eq "No bikes to return!"
	end


end