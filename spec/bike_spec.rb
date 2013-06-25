require 'bike'

describe Bike do
let(:my_bike){Bike.new}	
	
	it "should not be broken by default" do
		my_bike.broken?.should be_false
	end	

	it "should break and then be broken" do
		my_bike.break!
		my_bike.broken?.should be_true
	end

	it "can't be repaired unless it's broken" do
		my_bike.repair!.should eq "Can't repair a working bike!"
	end

	it "should be repaired and then not be broken and not return can't repair message" do
		my_bike.break!
		my_bike.repair!.should_not eq "Can't repair a working bike!"
		my_bike.broken?.should be_false
	end

end