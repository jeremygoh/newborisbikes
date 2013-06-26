class DockingStation
	attr_reader :bikes

	def initialize(number)
		@bikes=[]
		number.times{@bikes << Bike.new} unless number==0
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

	def full?
		@bikes.size==10
	end

	def receive(bike)
		if @bikes.size == 10
			"Can't receive anymore bikes. Capacity of ten bikes has been reached."
		else
			@bikes << bike
		end	
	end

	def rent
		if !has_bikes? 
			"Can't rent a bike. There aren't any bikes available."
		elsif !has_working_bikes?
			"Can't rent a bike as they are all broken."
		else
			@bikes.delete(working_bikes.pop)
		end
	end

	def capacity
		10 - @bikes.size
	end

	def has_working_bikes?
		!working_bikes.empty?
	end

	def release
		if !has_broken_bikes?
			"Can't release as no broken bikes!"
		else
			@bikes.delete(broken_bikes.pop)
		end	
	end
end