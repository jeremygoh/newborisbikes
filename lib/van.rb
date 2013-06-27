class Van

	attr_accessor :bikes

	def initialize
		@bikes = []
	end

	def has_bikes?
		!@bikes.empty?
	end

	def capacity
		10-@bikes.size
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
		if broken_bikes.size < number
			"Not enough broken bikes to deliver!"
		else
			number.times{
				garage.receive(broken_bikes.last)
				@bikes.delete(broken_bikes.pop)
			}
		end
	end

	def pick_up(garage, number)
		if garage.working_bikes.size < number
			"Not enough working bikes to collect from the garage!"
		elsif capacity < number
			"At maximum capacity. Can't pick up anymore bikes."
		else
			@bikes << garage.release(number)
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
			number.times{ 
				station.receive(working_bikes.last)
				@bikes.delete(working_bikes.pop)
			}
		end	

	end
end