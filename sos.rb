require_relative 'lib/xmlRequest.rb'
require_relative 'sosHelper.rb'

# Usage:
# 	s = SOS.new("Url")
# 	s.getCapabilities  => return All capabilities
# 	s.getObservations(condition)
#       => set the filter to get observations
# 	s.offering =>  return all offerings from @capability

# 	url = "http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service"
#   s  = SOS.new("YourService")

class SOS

	attr_reader :capabilities
	def initialize(url, args={})
		# request to http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service
		@request = XmlRequest.new(url)
		@capabilities = nil
		@observations, @gc, @go = nil

	end

	def getCapabilities(query={})
		@gc = SOSHelper::GetCapability.new(request: @request)
		@gc.send
		@capabilities = @gc.capabilities
	end

	def getObservations(condition={})
		@go = SOSHelper::GetObservation.new(request: @request)
		filter condition unless condition == {}
		@go
	end
	
	def offerings
		@offerings ||= @capabilities.contents.offering
	end
	
end