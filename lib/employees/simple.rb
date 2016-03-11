require_relative 'people.rb'

class Simple < People
	def do(tasks)
		raise ArgumentError, "It must be Array in the hash" unless task is_a? Array
		
		tasks = tasks.to_a.map do |task|
					tag inject task
				end
		tasks.join " "
	end

	def namespace
		"sos:"
	end
end