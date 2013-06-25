require 'garage'

describe Garage do
let(:my_garage){Garage.new}
	it "should have no bikes by default" do
		my_garage.has_bikes?.should be_false
	end

	it "should be able to receive bike and then have a bike" do
		bike = double :bike, broken?: true
		my_garage.receive(bike)
		my_garage.has_bikes?.should be_true
	end

	it "should not be able to receive a working bike" do
		bike = double :bike, broken?: false
		my_garage.receive(bike).should eq "We can't accept a working bike!"
	end

	it "should not be able to release a broken bike" do
		bike = double :bike, broken?: true
		my_garage.receive(bike)
		my_garage.release(bike).should eq "We can't release that bike. It's not been repaired yet!"
	end

	it "should not be able to release a bike if it has none" do
		my_garage.release(:bike).should eq "There are no bikes to release."
	end

	it "should not be able to repair a bike if it has none" do
		bike = double :bike, broken?: true
		my_garage.repair(bike).should eq "There are no bikes to repair!"
	end

	it "should be able to repair a bike" do
		bike = double :bike, broken?: true
		bike.should_receive(:repair!)

		my_garage.receive(bike)
		my_garage.repair(bike)
	end


end
