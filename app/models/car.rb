class Car

	# this defines the attributes the instance will have
	attr_accessor :seats, :color, :name, :gas, :miles_per_gallon, :miles

	# This is called when the .new function is called
	def initialize(seats, color, name, mpg, gallons_of_gas=10)
 
		# variables
		self.seats = seats
		self.color = color
		self.name = name

		self.miles_per_gallon = mpg.to_d
		self.gas = gallons_of_gas.to_d
	end

	# the car will try to drive that many miles or say you don't have enough gas
	def drive(miles)
		
		gas_needed = miles / self.miles_per_gallon 
		if gas_needed >= gas
			return "you don't have enough gas"
		else
			self.gas -= gas_needed
			self.miles += miles
			return "you drove #{miles} miles"
		end
	end

	# tells you how much gas you have
	def check_fuel
		return "You have #{gas.to_s} gallon(s)"
	end

	# describes the car (seats, color, name)
	def describe_the_car()
		return "This car seats #{seats} people, is #{color}, and is called: #{name}"
	end

	# Tells you how many wheels cars have
	def self.print_wheels()
		return "A car has 4 wheels"
	end

end