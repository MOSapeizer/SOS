require_relative 'lib/xmlRequest.rb'
require_relative 'sosHelper.rb'

# Usage:
# 	s = SOS.new("Url")
# 	s.getCapabilities  => return All capabilities
# 	s.getObservations(condition)
#       => set the filter to get observations


# 	s.offering =>  return all offerings from @capability

# 	url = "http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service"
# 	s = SOS.new(url)


class SOS

	def initialize(url, args={})
		# request to http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service
		@request = XmlRequest.new(url)
		@capabilities = getCapabilities
		@observations, @gc, @go = nil

	end

	def allowedValue
		@allowedValue ||= checkAllowedValues
	end
	
	def getCapabilities(query={})
		@gc = SOSHelper::GetCapability.new(request: @request)
		@capabilities = @gc.send
	end

	def checkAllowedValues
		@gc.checkAllowedValues
	end

	def getObservations(condition={})
		@go = SOSHelper::GetObservation.new(request: @request)
		filter condition
	end

	def filter(condition={})
		@go.filter condition
	end

	def send(&block)
		@observations = @go.send(&block) if block_given?
	end

	def offering
		@offerings = @offerings || @capabilities.xpath("//sos:Contents//swes:offering").map { |node| Offering.new(node) } unless @capabilities.nil?
	end
	
end

s = SOS.new("http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service")
s.getObservations