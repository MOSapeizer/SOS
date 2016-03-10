require_relative 'people.rb'

class Simple < People
	def do(tasks)
		tasks = tasks.to_a.map do |task|
			tag inject task
		end
		tasks.join " "
	end

end