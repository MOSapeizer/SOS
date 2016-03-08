require_relative 'xmlRequest.rb'
require_relative 'sosHelper.rb'
require_relative 'offering'

# Usage:
# 	s = SOS.new("http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service")  => implement 3 core function
# 	s.getCapabilities  => return All capabilities
# 	s.getObservations(1 day)
#       => set the filter to get observations
# 	s.offering =>  return all offerings from @capability
#   s.observation.filter().fiter().filter
# 	observation return self
# 

# 	url = "http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service"
# 	s = SOS.new(url)
# 	allowedValue = s.getCapabilities


class SOS

	def initialize(url, args={})
		# request to http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service
		@request = XmlRequest.new(url)
		@capabilities, @observations, @allowedValue = nil

	end
	
	def getCapabilities(query={})
		gc = SOSHelper::GetCapability.new(request: @request)
		@capabilities = gc.send
		@allowedValues = gc.checkAllowedValues
	end

	def getObservations(condition={})
		go = SOSHelper::GetObservation.new(request: @request)
		go.filter(condition)
		@observations = go.send()
	end

	def offering
		@offerings = @offerings || @capabilities.xpath("//sos:Contents//swes:offering").map { |node| Offering.new(node) } unless @capabilities.nil?
	end
	
end