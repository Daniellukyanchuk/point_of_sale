class Sandwich
  attr_accessor :meat, :cheese, :condiments
  
  def initialize(meat, cheese, condiments=[])
  	self.meat = meat
  	self.cheese = cheese
  	self.condiments = condiments
  end
end