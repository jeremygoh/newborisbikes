require 'cyclist'

describe Cyclist do
let(:my_cyclist){Cyclist.new}

	it "shouldn't have a bike by default" do
		my_cyclist.has_bike?.should be_false
	end
	
context "Renting a bike" do

	it "should be able to rent a bike and have one" do
		station = double :station
		station.should_receive(:rent).once.and_return :bike
		station.should_receive(:has_working_bikes?).and_return false
		my_cyclist.rent(station)
	end

	it "shouldn't be able to rent a bike if you have one and will return message" do
		station = double :station
		cyclist_with_bike=Cyclist.new
		cyclist_with_bike.instance_eval('@possession=[:bike]')
		cyclist_with_bike.rent(station).should eq "Can't rent a bike if you have one already."
	end

	it "shouldn't be able to rent a bike if the docking station won't let it and will return message" do
		station = double :station
		station.should_receive(:has_working_bikes?).and_return false
		station.should_receive(:rent)
		my_cyclist.rent(station)
	end	
end

	
context 'Breaking a bike' do
	it "should be able to break a bike" do
		bike = double :bike
		bike.should_receive(:break!)
		bike.should_receive(:broken?)
		my_cyclist.possession = [bike]
		my_cyclist.breaks_bike
	end

	it "can't break a bike if it doesn't have one" do
		my_cyclist.breaks_bike.should eq "No bike to break!"
	end	

	it "can't break a bike if it's already broken" do
		bike= double :bike, broken?:true
		my_cyclist.possession = [bike]
		my_cyclist.has_broken_bike?.should be_true
		my_cyclist.breaks_bike.should eq "Your bike is already broken!"
	end	
end

context 'Returning a bike' do
	it "should be able to return a bike" do
		my_cyclist.instance_eval('@possession=[:bike]')
		station = double :station
		station.should_receive(:receive)
		my_cyclist.return_bike(station)
	end

	it "should not be able to return a bike if it doesn't have one" do
		my_cyclist.has_bike?.should be_false
		:station
		my_cyclist.return_bike(:station).should eq "Can't return bike since you don't have one!"
	end	
end
	

end