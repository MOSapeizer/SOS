require_relative 'employees/offering.rb'

module SOSHelper
	class Boss
		def initialize(key, value)
			@employee = key
			@tasks = value.to_a
			@payment = nil
		end

		def done
			name = recognize_employee
			result = assign_tasks_to name
			paymentForYour result
		end

		def summarize(base=nil, bonus="")
			base.root.add_child bonus
		end

		def recognize_employee
			eval( @employee.to_s.capitalize + ".new")
		end

		def assign_tasks_to(you)
			you.do @tasks
		end

		def paymentForYour(result)
			@payment = result
		end

	end
end

a =  SOSHelper::Boss.new(:procedure, ["1", "2"])
p a.done