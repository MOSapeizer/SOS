require 'nokogiri'
require_relative 'factory'
require 'set'

module SOSHelper

	Urls = ["http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service",
			  "http://cgis.csrsr.ncu.edu.tw:8080/epa-sos/service",
			  "http://cgis.csrsr.ncu.edu.tw:8080/epa-aqx-sos/service"].freeze

	Relics = ["offering","observedProperty",
	     "featureOfInterest",
		 "procedure", "responseFormat",
		 "spatialFilter", "temporalFilter"].freeze


	ObservationRequest = File.open('request/getObservation.xml') { |f| Nokogiri::XML(f)  }

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

	# a = SOSHelper::GetObservation.new()
	# a.filter( { procedure: ["1", "2"]}).filter( { procedure: ["3", "2"]})
	# it'll raise error when condition is not a hash
	# a.filter([1, 2]) => 'Filter need to be hash error'


	class GetObservation

		def initialize(args={})
			@request = args[:request]
			# @capabilities = args[:capabilities]
			@xml = ObservationRequest.dup
		end

		def send(body=nil)
			raise RuntimeError, 'Need to set request' if @request.nil?
			body = condition.transform if body.nil?
			@request.post(body) { |res| next res }
		end

		# filter() =>  no argument to return @condtion
		# filter({:condition => "value"}) =>  with result to extend the filter
		def filter(custom={})
			raise ArgumentError, 'Filters need to be hash' unless custom.is_a? Hash
			return condition if custom == {}

			condition.merge! custom
			self
		end

		def inspect
			"<GetObservation 0x#{self.__id__} @condition= #{condition}>"
		end

		def condition
			@condition ||= Factory.new()
		end

	end
end

o = SOSHelper::GetObservation.new
c = o.filter({:procedure => "123"}).filter({:procedure => "344324"})
p c

# p o.uniform({ :procedure => "123"})


