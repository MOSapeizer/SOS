class People
	def initialize(tasks=nil)
		@tasks = tasks.to_a
	end

	def do(tasks)

	end

	def typeOf(task, args={})
		raise ArgumentError "Set check type" if args == {}
		type = args[:is] || args[:is_not]
		return task.class == type if not args[:is].nil?
		return task.class != type if not args[:is_not].nil?
	end

	def inspect
		tag
	end

	def inject(task)
		task if typeOf task, is: String
	end

	def tag(value=nil)
		"<#{namespace}#{self.class}>#{value.to_s}</#{namespace}#{self.class}>"
	end

	def namespace
		nil
	end

end