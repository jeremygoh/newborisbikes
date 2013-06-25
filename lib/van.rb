class Van

	def initialize
		@bikes = []
	end

	def has_bikes?
		!@bikes.empty?
	end

	def receive_from_docking(bike)
		if !bike.broken?
			"Can't receive a working bike!"
		elsif  @bikes.size == 10
			"At maximum capacity. Can't receive anymore bikes!"
		else	
			@bikes << bike
		end
	end

	def broken_bikes
		@bikes.select{|bike| bike.broken?}
	end

	def deliver(bike)
		if @bikes.empty?
			"No bikes to deliver."
		elsif !bike.broken?
			"Can't deliver a working bike to the garage!"		
		else
			@bikes.delete(broken_bikes.pop)
		end	
	end

	def pick_up(bike)
		if bike.broken?
			"Can't pick up bike as it hasn't been repaired yet."
		elsif @bikes.size == 10
			"At maximum capacity. Can't pick up anymore bikes."
		else
			@bikes << bike
		end
	end

	def working_bikes
		@bikes.select{|bike| !bike.broken?}
	end

	def return(bike)
		if @bikes.empty?
			"No bikes to return!"
		elsif bike.broken?
			"Can't return a broken bike to the docking station!"
		end
	end
end