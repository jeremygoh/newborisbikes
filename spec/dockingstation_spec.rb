require 'dockingstation'

describe DockingStation do
let(:my_station){ DockingStation.new }

	it "should not have bikes by default" do
		my_station.has_bikes?.should be_false
	end	

context "Renting a bike" do
	it "should rent a bike and have one less bike" do
		bike = double :bike, broken?: false
		my_station.receive(bike)
		my_station.rent(bike)
		my_station.should_not have_bikes
	end

	it "should not rent a bike if it doesn't have any" do
		my_station.rent(:bike).should eq "Can't rent a bike. There aren't any bikes available."
	end

	it "can't rent a bike if it only has a broken bike" do
		bike = double :bike
		bike.should_receive(:broken?).and_return true
		my_station.receive(bike)
		my_station.rent(:bike).should eq "Can't rent a bike as they are all broken."
	end

	it "can rent a bike if it has a working bike and one non-working bike" do
		working_bike = double :bike, broken?:false
		broken_bike = double :bike, broken?:true
		my_station.receive(working_bike)
		my_station.receive(broken_bike)
		my_station.rent(working_bike)
		my_station.working_bikes.size.should eq 0
	end

	it 'has one less rentable bike after renting out a bike' do
		bike = double :bike, broken?:false
		my_station.receive(bike)
		my_station.rent(bike)
		my_station.working_bikes.size.should eq 0
	end
end

context "Receiving a bike from a cyclist" do 

	it "should receive a bike and have one more bike" do
		my_station.receive(:bike)
		my_station.should have_bikes
	end

	it "can receive a broken bike" do
		bike = double :bike
		bike.should_receive(:broken?).and_return true
		my_station.receive(bike)
		my_station.has_broken_bikes?.should be_true
	end

	it 'can receive a bikes' do
		bike = double :bike, broken?: false
		my_station.receive(bike)
		my_station.working_bikes.should include bike
	end

	it "can't receive a bike if it is at maximum capacity, i.e. 10" do
		10.times{my_station.receive(:bike)}
		my_station.receive(:bike).should eq "Can't receive anymore bikes. Capacity of ten bikes has been reached."
	end
end

#could I make the test below

	
context "Releasing a bike for a van" do
	it "can't release a non-broken bike" do
		bike = double :bike, broken?:false
		my_station.receive(bike)
		my_station.release(bike).should eq "Can't release a working bike! You have to rent it!"
	end

	it "can't release a working bike and it should return an error message" do
		bike = double :bike, broken?:false
		my_station.receive(bike)
		my_station.release(bike).should eq "Can't release a working bike! You have to rent it!"
	end

	it "can release a broken bike and will have one less broken bike" do
		bike = double :bike, broken?:true
		my_station.receive(bike)
		my_station.broken_bikes.size.should eq 1
		my_station.release(bike)
		my_station.broken_bikes.size.should eq 0
	end

end

end