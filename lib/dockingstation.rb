class DockingStation

	def initialize
		@bikes=[]
	end

	def has_bikes?
		!@bikes.empty?
	end

	def has_broken_bikes?
		!broken_bikes.empty?
	end

	def broken_bikes
		@bikes.select{|bike| bike.broken?}
	end

	def working_bikes
		@bikes.reject{|bike| bike.broken?}
	end

	def receive(bike)
		if @bikes.size == 10
			"Can't receive anymore bikes. Capacity of ten bikes has been reached."
		else
			@bikes << bike
		end	
	end

	def rent(bike)
		if !has_bikes? 
			"Can't rent a bike. There aren't any bikes available."
		elsif !has_working_bikes?
			"Can't rent a bike as they are all broken."
		else
			@bikes.delete(working_bikes.pop)
		end
	end

	def has_working_bikes?
		!working_bikes.empty?
	end

	def release(bike)
		if !bike.broken?
			"Can't release a working bike! You have to rent it!"	
		else
			@bikes.delete(broken_bikes.pop)
		end	
	end
end