class Factory < Hash
	attr_reader :condition
	def initialize(custom={}, boss=nil)
		@condition = uniform custom
	end

	def uniform(custom)
		custom.each do |k, v| 
			custom[k] = [v].to_set unless v.is_a? Array
			custom[k] = custom[k].to_set unless v.is_a? Set
		end
	end

	# need fix to check
	def transform(boss, obj=nil)
		conditions = obj || condition
		checkBehaviorOf(conditions).each do |key, value|
			tag = Nokogiri::XML::Node.new(key.to_s, boss)
			tag.content = value
			boss.root.add_child tag
		end

		boss.to_xml
	end

	def checkBehaviorOf(obj)
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