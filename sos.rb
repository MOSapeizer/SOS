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
#   s.getObservations
#   s.filter({filter: { During: ["1"] }})
#   s.filter({filter: { During: ["2", {fuck: "test"}] }})
#   s.filter({offering: "1"})
#    .filter({offering: "2"})
#    .filter({offering: "3"})
#    .filter({offering: "4"})
#   p s.condition
#   => '{:filter=>
#   		{:During=>#<Set: {"1", "2", 
#   			{:fuck=>#<Set: {"test"}>}}>}, 
#   	 :offering=>#<Set: {"1", "2", "3", "4"}>}'

#   f = Factory.new()
#   p f.transform(SOSHelper::ObservationRequest.dup, s.condition)


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
		filter condition unless condition == {}
		@go
	end
	
	def offering
		@offerings = @offerings || @capabilities.xpath("//sos:Contents//swes:offering").map { |node| Offering.new(node) } unless @capabilities.nil?
	end
	
end