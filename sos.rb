require_relative 'xmlRequest.rb'
require_relative 'sosHelper.rb'

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
		@capabilities = getCapabilities
		@observations = nil
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

	def getObservations(condition={}, &block)
		go = SOSHelper::GetObservation.new(request: @request)
		go.filter(condition)
		@observations = go.send(&block)
	end

	def offering
		@offerings = @offerings || @capabilities.xpath("//sos:Contents//swes:offering").map { |node| Offering.new(node) } unless @capabilities.nil?
	end
	
end

s = SOS.new("http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service")
# p s.allowedValue

p s.getObservations