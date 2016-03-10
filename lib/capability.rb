module SOSHelper
	class GetCapability

		def initialize(args={})
			@request = args[:request]
			@url = args[:url]
			@query = {}
			@allowedValue = {}
			@capabilities = nil
		end

		def send(query={})
			query[:service] = query[:service] || "SOS"
			query[:request] = query[:request] || "GetCapabilities"
			@capabilities = request.get(query) { |str| next Nokogiri::XML(str) }
		end

		def checkAllowedValues(capabilities=nil)

			@allowedValue = check Relics
		end

		private

		def dig(operation, type="Value")
			@capabilities.xpath("//ows:Operation[@name='GetObservation']//ows:Parameter[@name='#{operation}']//ows:#{type}")
		end

		def request
			@request ||= XmlRequest.new(@url)
		end

		def check(relics)
			backpack = {}

			relics.each do |relic|
				level = checkLevelOf relic

				backpack[ relic.to_sym ] = adventure level, relic
			end

			backpack
		end

		def adventure(level, relic)
			if level == "normal"
				(dig relic).map { |treasure| normal treasure }
			else
				(dig relic, "Range").map { |treasure| complex treasure}
			end
		end

		def checkLevelOf(condition)
			!(condition.include? "Filter") ? "normal" : "complex"
		end

		def normal(tag)
			tag.text
		end

		def complex(tag)
			[tag.xpath(".//ows:MinimumValue").text, tag.xpath(".//ows:MaximumValue").text]
		end
	end
end