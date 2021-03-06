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
			@body = ""
		end

		# Without preset Conditions is Okay
		def send(body=nil, &block)
			raise RuntimeError, 'Need to set request' if @request.nil?
			@body = condition.transform @xml if body.nil?
			@request.post(@body, &block) if block_given?
		end

		def body(body=nil)
			@body = body
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

		def offering(list)
			filter({offering: list})
		end

		def procedure(list)
			filter({procedure: list})
		end

		def observedProperty(list)
			filter({observedProperty: list})
		end

		def temporalFilter(id, range)
			filter({ temporalFilter: {
						during: {
				 			valueReference: "phenomenonTime",
				 			timePeriod: { attributes: { id: id }, range: range } }
					  	}
		  			})
		end

	end

end