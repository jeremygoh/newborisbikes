class Garage
	attr_accessor :bikes
	
	def initialize
		@bikes = []
	end

	def has_bikes?
		!@bikes.empty?
	end

	def receive(bike)
		if !bike.broken?
			"We can't accept a working bike!"
		else
			@bikes << bike
		end
	end

	def release(number)
		if working_bikes.size < number
			"We don't have enough repaired bikes to release!"
		else
			@bikes.delete(working_bikes.pop)
		end


	end

	def broken_bikes
		@bikes.select{|bike| bike.broken?}
	end

	def has_broken_bikes?
		!broken_bikes.empty?
	end	

	def repair(number)
		if !has_broken_bikes?
			"No bikes to repair!"

		elsif number > broken_bikes.size
			"Not enough bikes to repair!"
		else	
			number.times { |n| broken_bikes.pop.repair! }
		end

	end

	def working_bikes
		@bikes.select{|bike| !bike.broken?}
	end

end