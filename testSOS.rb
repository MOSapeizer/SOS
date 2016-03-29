class TestSOS
	def initialize(url)
		@service = SOS.new(url)
		@service.getCapabilities
		@offerings = @service.offerings
		@offering = @offerings[2]
		@beginTime, @endTime = timeIn 1
	end

	def day
		60*60*24
	end

	def endPosition
		offering.phenomenonTime.endPosition
	end

	def timeIn(range, offset=0)
		endTime = endPosition - offset * day
		beginTime = endTime - range * day
		[beginTime, endTime]
	end

	def offering(index=nil)
		@offering = @offerings[index] if not index.nil?
		@offering
	end

	def totalOffering
		@offerings.size
	end

	def getDay(offset=0)
		range = timeIn 1, offset
		sendTo range
	end

	def getMonth(offset=0)
		range = timeIn 30
		sendTo range
		
	end

	def sendTo(range)
		offering.observableProperty.each do |property|
			start = Time.now
			request property, range
			stop = Time.now
			puts "#{property} finished in #{stop - start}"
		end
	end

	def request(property, range)
		req = @service.getObservations
		req.offering = offering.identifier
		req.observedProperty = property
		req.temporalFilter = offering.phenomenonTime.range(range[0], range[1])
		time = range[0].utc.to_s.split(" ").join "_"
		filename = property.split(":")[-1]
		p filename
		req.send { |response| File.new("./response/tmp_#{filename}_" + time, "w").write response }
	end
end