require_relative 'node'

module SOSHelper
	class Offering
		ATRRIBUTES = [ :identifier, :procedure, :observableProperty, :observedArea, :resultTime, :phenomenonTime, :node ]
		ATRRIBUTES.each { |t| attr_reader t }

		def initialize(xml_offer)
			@node = Node.new xml_offer
			@id, @procedure = getText(:id), getText(:procedure)
			@observableProperty = getList(:observableProperty)
			@observedArea = getHash(:observedArea, [:lowerCorner, :upperCorner])
			@phenomenonTime = getHash(:phenomenonTime, [:begin, :end])
			@resultTime = getHash(:resultTime, [:begin, :end])

		end

		def getText(name)
			@node[name].text
		end

		def getList(name)
			@node[name].children.map { |node| node.text }
		end

		def getHash(name, scope=[])
			hash = {}
			scope.each { |s| hash.store(s, @node[name][s].text )} unless scope.empty?
			hash
		end

		def to_json
			{ "identifier": @id, 
			  "procedure": @procedure,
			  "observableProperty": @observableProperty,
			  "observedArea": @observedArea,
			  "phenomenonTime": @phenomenonTime,
			  "resultTime": @resultTime }
		end

		def to_s
			to_json.to_s
		end

	end

end
# p a.node.inspect
# p a.to_json