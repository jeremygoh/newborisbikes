class Bike

	def initialize
		@broken = false
	end

	def broken?
		@broken
	end

	def break!
		@broken = true
	end

	def repair!
		if !@broken
			"Can't repair a working bike!"
		else
			@broken = false
		end
	end

end