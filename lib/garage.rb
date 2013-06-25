class Garage
	
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

	def release(bike)
		if @bikes.empty?
			"There are no bikes to release."
		elsif bike.broken?
			"We can't release that bike. It's not been repaired yet!"
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