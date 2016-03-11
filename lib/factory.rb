require_relative 'boss.rb'


# a = Factory.new
# a.merge!({offering: "1"})
# a.merge!({offering: "2"})
# a.merge!({offering: "3"})
# p a.merge!({offering: "4"})

# p a.transform SOSHelper::ObservationRequest.dup

class Factory < Hash
	attr_reader :condition
	def initialize(custom={})
		@condition = uniform custom
	end

	# uniform 
	def uniform(custom)
		custom.each do |k, v| 
			next if v.is_a? Set
			custom[k] = [v].to_set unless v.is_a? Array
			custom[k] = custom[k].to_set unless v.is_a? Set
		end

		p custom
	end

	# notify boss we have new tasks
	# and send our base to him
	def transform(base, obj=nil)
		conditions = obj || condition
		projects = checkOf conditions 
		jobs = Boss.new base, projects
		achievements = jobs.assign

		achievements.to_xml
	end

	def checkOf(obj)
		return condition.dup if obj.respond_to? :condition
		uniform(obj)
	end

	def merge! custom
		uniform custom
		self.condition.merge! (custom) do |key, origin, custom|
				origin.merge custom.to_set
		end
	end

	def to_s
		@condition.to_s
	end
end