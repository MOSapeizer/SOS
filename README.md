# SOS

This is a implementation Of Sensor Observation Service
You can just send Get Capability Request to Specific Url

GetObservation is developing, suggest to not use it.

Example:

 	s = SOS.new("http://your/web/service")
  	s.getCapabilities  => return All capabilities

  	and you can check Allowed Value

  	s.allowedValue
 	s.offering =>  return all offerings from @capability


Now Developing:

 	s.getObservations => not work yet

 	If you want to custom GetObservation

 	go = SOSHelper::GetObservation.new

    go.filter({offering: "name"})
	go.filter({procedure: "sensor"})
	go.filter({responseFromate: "application/json"})

 	there is another way:

 	go.filter({offering: "name"})
 	  .filter({procedure: "sensor"})
 	  .filter({responseFromate: "application/json"})
   

Send me email if you have suggestions

k471352@gmail.com