require_relative 'simple.rb'

class Offering < Simple
	def namespace
		"sos:"
	end
end

class Procedure < Simple
	def namespace
		"sos:"
	end
end

# a = Procedure.new()
# p a.do ["1", "2", "3", "4", "5"]