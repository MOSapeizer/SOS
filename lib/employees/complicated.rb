require_relative 'people.rb'

class Complicated < People
	def do(tasks)
		tasks = tasks.to_a.map do |task|
			assigns task if checkTypeOf task, Hash
		end
		tasks.join " "
		
	end

	def assigns(task)
		report = ""
		task.each do |subordinate, subtask|
			# problem: no key?
			subordinate = eval( subordinate.to_s + ".new")
			report += subordinate.do(subtask)
		end
		report
	end

	def tag(value=nil, attrs={})
		"<#{self.class} #{attributes attrs}#>#{value.to_s}</#{self.class}>"
	end

	def attributes(attrs)
		attributes_all = ""
		attrs.each { |k, v| attributes_all += k.to_s + "=" + v.to_s + " " }
		attributes_all
	end

end