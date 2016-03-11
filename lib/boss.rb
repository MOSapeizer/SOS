require_relative 'employees/offering.rb'

module SOSHelper

	# Boss Assign the tasks
	# Assign class check each task is done by a correct employee
	# Assign workflow:
	# 	1. recognize key as a employee
	# 	2. assign tasks to him
	# 	3. Boss summerize the base and results

	class Boss
		def initialize(base, projects)
			@base = base
			@projects = projects
		end

		def assign
			@projects.each do |employee, task|
				pm = ProjectManager.new(employee, task)
				results = pm.done
				summarize @base, results
			end

			@base
		end

		def summarize(base=nil, bonus="")
			base.root.add_child bonus
		end

	end

	class ProjectManager
		def initialize(key, value)
			@employee = key
			@tasks = value.to_a
			@results = nil
		end

		def done
			name = recognize_employee
			@results = assign_tasks_to name
		end

		def recognize_employee
			eval( @employee.to_s.capitalize + ".new")
		end

		def assign_tasks_to(you)
			you.do @tasks
		end
	end
end

# a =  SOSHelper::Boss.new(:procedure, ["1", "2"])
# p a.done