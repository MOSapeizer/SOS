module SOSHelper
	class Boss

		def initialize(key, value)
			@employee = key
			@tasks = value
		end

		def done
			nil
		end

		def summarize(base=nil, bonus=nil)
			
		end

		def procedure(value)
			p = Nokogiri::XML::Node.new(key.to_s, boss)
			p.content = value
		end

	end
end