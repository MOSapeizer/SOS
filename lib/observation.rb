module SOSHelper
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