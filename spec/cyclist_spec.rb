require 'cyclist'

describe Cyclist do
let(:my_cyclist){Cyclist.new}

	it "shouldn't have a bike by default" do
		my_cyclist.has_bike?.should be_false
	end
	
context "Renting a bike" do

	it "should be able to rent a bike and have one" do
		my_cyclist.rent(:bike)
		my_cyclist.has_bike?.should be_true
	end

	it "shouldn't be able to rent a bike if you have one" do
		my_cyclist.rent(:bike)
		my_cyclist.rent(:bike).should eq "Can't rent a bike if you have one already."
	end
end

	# it "shouldn't be able to rent a bike if there are no working bikes left at the docking station" do
	# 	station = :dockingstation, 
context 'Breaking a bike' do
	it "should be able to break a bike and then have a broken bike" do
		bike = double :bike
		bike.should_receive(:break!)
		bike.should_receive(:broken?).and_return true
		my_cyclist.rent(bike)
		my_cyclist.breaks_bike
		my_cyclist.has_broken_bike?.should be_true
	end
end

context 'Returning a bike' do
	it "should be able to return a bike and have no bike" do
		my_cyclist.rent(:bike)
		my_cyclist.return_bike
		my_cyclist.has_bike?.should be_false
	end
end
	

end