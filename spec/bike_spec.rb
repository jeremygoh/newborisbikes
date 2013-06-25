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

end