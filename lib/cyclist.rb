class Cyclist

	def initialize
		@possession = []
	end	

	def has_bike?
		!@possession.empty?
	end

	def rent(bike)
		if has_bike?
			"Can't rent a bike if you have one already."
		else
			@possession << bike
		end
	end


	def breaks_bike
		@possession.first.break!
	end

	def has_broken_bike?
		@possession.first.broken?
	end

	def return_bike
		@possession.pop
	end

end