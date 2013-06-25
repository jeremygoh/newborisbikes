require 'dockingstation'

describe DockingStation do
let(:my_station){ DockingStation.new }

	it "should not have bikes by default" do
		my_station.has_bikes?.should be_false
	end

	it "should receive a bike and have one more bike" do
		my_station.receive(:bike)
		my_station.should have_bikes
	end

	it "should rent a bike and have one less bike" do
		bike = double :bike, broken?: false
		my_station.receive(bike)
		my_station.rent(bike)
		my_station.should_not have_bikes
	end

	it "should not rent a bike if it doesn't have any" do
		my_station.rent(:bike).should eq "Can't rent a bike. There aren't any bikes available."
	end

	it "can have a broken bike" do
		bike = double :bike
		bike.should_receive(:broken?).and_return true
		my_station.receive(bike)
		my_station.has_broken_bikes?.should be_true
	end

	it "can't rent a bike if it only has a broken bike" do
		bike = double :bike
		bike.should_receive(:broken?).and_return true
		my_station.receive(bike)
		my_station.rent(:bike).should eq "Can't rent a bike as they are all broken."
	end

	it 'has rentable bikes' do
		bike = double :bike, broken?: false
		my_station.receive(bike)
		my_station.rentable_bikes.should include bike
	end

#could I make the test below
	it 'has one less rentable bike after renting out a bike' do
		bike1 = double :bike, broken?:false
		bike2 = double :bike, broken?:false
		my_station.receive(bike1)
		my_station.receive(bike2)
		workingbikesnumber = my_station.rentable_bikes.count
		my_station.rent(:bike)
		finalbikesnumber = my_station.rentable_bikes.count
		(workingbikesnumber - finalbikesnumber).should eq 1
	end
	
	it "can't accept a bike if it is at maximum capacity, i.e. 10" do
		10.times{my_station.receive(:bike)}
		my_station.receive(:bike).should eq "Can't receive anymore bikes. Capacity of ten bikes has been reached."
	end

end