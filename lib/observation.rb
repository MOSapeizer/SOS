module SOSHelper

	class Observation
		def initialize(args)
			
		end
	end

	# GetObservation just focus on two things:
	# 		filter conditions into hash
	# 		send the conditions to specific @request
	class GetObservation

		def initialize(args={})
			@request = args[:request]
			@xml = ObservationRequest.dup
			@request_body = nil
		end

		# Without preset Conditions is Okay
		def send(body=nil, &block)
			raise RuntimeError, 'Need to set request' if @request.nil?
			body = condition.transform @xml if body.nil?
			@request.post(body, &block) if block_given?
		end

		def body(body=nil)
			condition.transform @xml if body.nil?
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