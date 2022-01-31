module CustomMatcher
  class OurCustomMatcher
    def initialize(target)
    	@target = target
    end

  	def matches?(value)
  		value == @target 
  	end

  	def failure_message
  		"Our matcher failed to match"
  	end
  end

  def self.custom_matcher(target)
  	OurCustomMatcher.new(target)
  end
end