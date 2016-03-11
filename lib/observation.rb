module SOSHelper

	# GetObservation just focus on two things:
	# 		filter conditions into hash
	# 		send the conditions to specific @request
	class GetObservation

		def initialize(args={})
			@request = args[:request]
			@xml = ObservationRequest.dup
		end

		# Without preset Conditions is Okay
		def send(body=nil)
			raise RuntimeError, 'Need to set request' if @request.nil?
			body = condition.transform @xml if body.nil?
			@request.post(body) { |res| next res }
		end

		# filter() =>  no argument to return @condtion
		# filter({:condition => "value"}) =>  extend @condition
		def filter(custom={})
			raise ArgumentError, 'Filters need to be hash' unless custom.is_a? Hash
			return condition.to_s if custom == {}
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