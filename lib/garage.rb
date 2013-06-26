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

	def repair(bike)
		if @bikes.empty?
			"There are no bikes to repair!"
		elsif !bike.broken?
			"It is impossible to repair a working bike!"
		else
			bike.repair!
		end

	end

	def working_bikes
		@bikes.select{|bike| !bike.broken?}
	end

end