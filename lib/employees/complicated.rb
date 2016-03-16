require_relative 'people.rb'
require 'set'

#   => '{:filter=>
#   		{:During=>#<Set: {"1", "2", 
#   			{:fuck=>#<Set: {"test"}>}}>}, 
#   	 :offering=>#<Set: {"1", "2", "3", "4"}>}'
class Complicated < People
	def do(tasks)
		result = plan(tasks).map do |task|
					next assigns task if typeOf task, is: Hash
					next self.do task if typeOf task, is: Array
					next complete task if typeOf task, is: String
				end
		result.join " "
	end

	def complete(task)
		tag task
	end

	def plan(task)
		return task.to_a if typeOf task, is: Set
		return task if typeOf task, is: Array
		[task]
	end

	def assigns(task)
		report = ""
		task.each do |subordinate, subtask|
			# problem: no key?
			subordinate = eval( capitalize(subordinate.to_s) + ".new")
			report += subordinate.do plan(subtask)
		end
		report
	end

	def tag(value=nil, attrs={})
		"<#{namespace}#{tag_name}#{attributes attrs}#>#{value.to_s}</#{namespace}#{tag_name}>"
	end

end