require_relative 'boss.rb'
require 'set'

# a = Factory.new
# a.merge!({offering: "1"})
# a.merge!({offering: "2"})
# a.merge!({offering: "3"})
# p a.merge!({offering: "4"})
# p a.transform SOSHelper::ObservationRequest.dup


# Factory focus on three things:
#   1. uniform the hash
#   2. extend condition
#   3. transform the condition
class Factory < Hash
	def initialize(custom={})
		@condition = uniform custom
	end

	# uniform any hash
	def uniform(custom)
		custom.each do |k, v| 
			next if v.is_a? Set
			next (custom[k] = uniform v) if v.is_a? Hash
			next (custom[k] = magic v) if v.is_a? Array
			custom[k] = [v].to_set unless v.is_a? Array
			custom[k] = custom[k].to_set unless v.is_a? Set
		end		
		# p "extend filter with: " + custom.to_s
		custom
	end

	# notify boss we have new tasks
	# and send our base to him
	def transform(base, obj=nil)
		conditions = obj || condition
		projects = checkOf conditions 
		jobs = SOSHelper::Boss.new base, projects
		achievements = jobs.assign

		achievements.to_xml
	end

	def magic(paragraph)
		paragraph.each { |too_detail| DontWantToRefactorThisBecauseItIs too_detail }.to_set
	end

	def DontWantToRefactorThisBecauseItIs(too_detail)
		uniform too_detail if not too_detail.is_a? String
	end

	def checkOf(obj)
		return condition.dup if obj.respond_to? :condition
		uniform(obj)
	end

	def merge! custom
		uniform custom
		# mergeTheHellOf(self.condition, custom)
		mergeMagic(self.condition, custom)
	end

	def mergeMagic(origin, custom)
		if origin.respond_to? :merge!
			origin.merge! (custom) do |key, origin, custom|
				origin = [origin].to_set if not origin.is_a? Set
				custom = [custom].to_set if not custom.is_a? Set
				next mergeTheSmartWay origin, custom
			end
		else
			origin + custom
		end
	end

	def mergeTheSmartWay(origin, custom)
		origin_hash, pure_origin_string = split origin
		custom_hash, pure_custom_string = split custom
		sum_hash = mergeHash origin_hash, custom_hash
		summary = pure_origin_string + pure_custom_string + sum_hash.to_set
	end

	def mergeHash(origin, custom)
		custom.each do |node|
			mergeNodeInHash node, origin
		end
		origin
	end

	def mergeNodeInHash(node, origin)
		flag = true
		origin.each do |hash|
			if hash.keys == node.keys
				flag = false
				next recursiveMerge(hash, node)
			end
		end
		origin << node if flag
	end

	def recursiveMerge(origin, custom)
		origin.merge! custom do |key, origin, custom|
			mergeMagic origin, custom
		end
	end

	def split(set)
		hash = set.to_a.keep_if { |value| value.is_a? Hash  }
		string = set - hash
		return hash, string.to_set
	end

	def to_s
		@condition
	end

	alias :condition :to_s
end 
