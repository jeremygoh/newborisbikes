class Cyclist

	attr_accessor :possession

	def initialize
		@possession = []
	end	

	def has_bike?
		!@possession.empty?
	end

	def rent(station)
		if has_bike?
			"Can't rent a bike if you have one already."
		elsif !station.has_working_bikes?
			station.rent
		else
			@possession << station.rent 
		end
	end


	def breaks_bike
		if !has_bike?
			"No bike to break!"
		elsif has_broken_bike?
			"Your bike is already broken!"
		else	
			@possession.first.break!
		end
	end

	def has_broken_bike?
		@possession.first.broken?
	end

	def return_bike(station)
		if !has_bike?
			"Can't return bike since you don't have one!"
		else	
			station.receive(@possession.pop)
		end
	end

end