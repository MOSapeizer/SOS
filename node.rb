class Node
	NAMESPACE = { id: "swes:identifier", 
				  procedure: "swes:procedure", 
				  observableProperty: "swes:observableProperty",
				  observedArea: "sos:observedArea",
				  envelope: "gml:Envelope",
				  lowerCorner: "gml:lowerCorner",
				  upperCorner: "gml:upperCorner",
				  timePeriod: "gml:TimePeriod",
				  phenomenonTime: "sos:phenomenonTime",
				  begin: "gml:beginPosition",
				  end: "gml:endPosition",
				  resultTime: "sos:resultTime"}

	def initialize(node)
		@node = node.dup
	end

	def [](name)
		Node.new @node.xpath(".//#{NAMESPACE[name]}")
	end

	def method_missing(name)
		@node.send(name)
	end

	def inspect
		self.to_s
	end
end