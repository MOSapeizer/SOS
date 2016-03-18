require 'set'
require 'nokogiri'
Dir[ File.dirname(__FILE__) + "/employees/*.rb"].each {|file| require file }
require_relative 'board_of_directors/factory/factory.rb'
require_relative 'board_of_directors/boss.rb'
Dir[ File.dirname(__FILE__) + "/sos_helper/*.rb"].each {|file| require file }

module SOSHelper

	Urls = [ "http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service",
			 "http://cgis.csrsr.ncu.edu.tw:8080/epa-sos/service",
			 "http://cgis.csrsr.ncu.edu.tw:8080/epa-aqx-sos/service"].freeze

	Relics = [ "offering","observedProperty",
		       "featureOfInterest",
			   "procedure", "spatialFilter", 
			   "temporalFilter", "responseFormat"].freeze

	ObservationRequest = File.open(File.dirname(__FILE__) + '/sos_helper/getObservation.xml') { |f| Nokogiri::XML(f)  }.freeze

end