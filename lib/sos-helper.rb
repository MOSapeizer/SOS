require 'set'
require 'nokogiri'
Dir[ File.dirname(__FILE__) + "/employees/*.rb"].each {|file| require file }
require_relative 'board_of_directors/factory/factory.rb'
require_relative 'board_of_directors/boss.rb'
Dir[ File.dirname(__FILE__) + "/sos_helper/*.rb"].each {|file| require file }

module SOSHelper
	Dir[ File.dirname(__FILE__) + "/sos_helper/*.rb"]
	Urls = [ "http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service",
			 "http://cgis.csrsr.ncu.edu.tw:8080/epa-sos/service",
			 "http://cgis.csrsr.ncu.edu.tw:8080/epa-aqx-sos/service"].freeze

	Relics = [ "offering","observedProperty",
		       "featureOfInterest",
			   "procedure", "spatialFilter", 
			   "temporalFilter", "responseFormat"].freeze

	ObservationRequestXML = <<-REQUEST
							<?xml version="1.0" encoding="UTF-8"?>
							<sos:GetObservation
						    xmlns:sos="http://www.opengis.net/sos/2.0"
						    xmlns:fes="http://www.opengis.net/fes/2.0"
						    xmlns:gml="http://www.opengis.net/gml/3.2"
						    xmlns:swe="http://www.opengis.net/swe/2.0"
						    xmlns:xlink="http://www.w3.org/1999/xlink"
						    xmlns:swes="http://www.opengis.net/swes/2.0"
						    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" service="SOS" version="2.0.0" xsi:schemaLocation="http://www.opengis.net/sos/2.0 http://schemas.opengis.net/sos/2.0/sos.xsd">\n  </sos:GetObservation>
						    REQUEST

    ObservationRequest = Nokogiri::XML(ObservationRequestXML)

end