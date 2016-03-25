require_relative '../gml/gmlTime.rb'

class SOSTime
	def initialize(time)
		@time = checkTimeType time
	end

	def timeInstant(time)
		time.xpath(".//gml:TimeInstant") 
	end

	def timePeriod(time)
		time.xpath(".//gml:TimePeriod")
	end

	def timePosition
		@instant ||= GMLTime.new find("gml:timePosition")
	end

	def beginPosition
		@begin ||= GMLTime.new find("gml:beginPosition")
	end

	def endPosition
		@end ||= GMLTime.new find("gml:endPosition")
	end

	def find(tag)
		@time.xpath(".//" + tag).text
	end

	def checkTimeType(time)
		type = timeInstant time
		type = timePeriod time if type.empty?
	end
end

class PhenomenonTime < SOSTime

end

class ResultTime < SOSTime
	
end