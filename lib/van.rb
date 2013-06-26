class Van

	attr_accessor :bikes

	def initialize
		@bikes = []
	end

	def has_bikes?
		!@bikes.empty?
	end

	def receive_from_docking(station, number)
		if @bikes.size==10
			"At maximum capacity. Can't receive anymore bikes!"
		elsif station.broken_bikes.size < number
			"There aren't enough broken bikes"
		else
			number.times{@bikes << station.release}
		end
	end

	def broken_bikes
		@bikes.select{|bike| bike.broken?}
	end

	def deliver(garage, number)
		if broken_bikes.empty?
			"No broken bikes to deliver!"
		else
			number.times{@bikes.delete(broken_bikes.pop)}
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

	def return(station, number)
		if number > station.capacity
			"Not enough space in the dock to return that number of bikes!"
		elsif number > working_bikes.size
			"Not enough working bikes to return!"
		else
			number.times{ @bikes.delete(working_bikes.pop)}
		end	

	end
end