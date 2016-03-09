class Factory < Hash
	attr_reader :condition
	def initialize(custom={}, boss=nil)
		@condition = custom
		# uniform @condition
	end

	def uniform(custom)
		custom.each do |k, v| 
			custom[k] = [v].to_set unless v.is_a? Array
			custom[k] = custom[k].to_set unless v.is_a? Set
		end
	end

	def transform(obj=nil)
		conditions = getConditionOf obj
		conditions.each do |key, value|
			tag = Nokogiri::XML::Node.new(key.to_s, @xml)
			tag.content = parse value
			@xml.root.add_child tag
		end

		@xml.to_xml
	end

	def getConditionOf(obj)
		return self.condition.dup if obj.respond_to? :condition
		condition.dup
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