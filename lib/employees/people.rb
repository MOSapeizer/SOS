class People
	def initialize(tasks=nil)
		@tasks = tasks.to_a
	end

	def do(tasks)

	end

	def checkTypeOf(task, type)
		return task.class
	end

	def inspect
		tag
	end

	def inject(task)
		return task if checkTypeOf task.class, String
		nil
	end

	def tag(value=nil)
		"<#{namespace}#{self.class}>#{value.to_s}</#{namespace}#{self.class}>"
	end

	def namespace
		nil
	end

end