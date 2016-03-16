# SOS

This is a implementation Of Sensor Observation Service
You can just send Get Capability Request to Specific Url

## Supporting Functionality

- [x] GetCapibility
- [ ] DescribeSensor (developing)
- [x] GetObservation (parts)

## Tutorial

### GetCapibility Example:

```ruby
service = SOS.new("http://your/sos/web/service")
service.getCapabilities 

p service.allowedValue

service.allowedValue
s.offering =>  return all offerings from @capability
```

### Check Allowed Value

	
```ruby 
list = service.allowedValue

list.keys
	
# [ :offering, 
#  	:observedProperty, 
#  	:featureOfInterest, 
#  	:procedure, 
#  	:spatialFilter, 
#  	:temporalFilter, 
#  	:responseFormat ]
```

The list is pure Hash, simply use it like


```ruby 

list[:offering] # list all offerings of the SOS service 

list[:responseFormat][0] # return a string

```

### GetObservation

```ruby 
service.getObservation

service.filter({  offering: "name",
				  observedProperty: "properties",
				  temporalFilter: {
 					 during: {
 					 	valueReference: "phenomenonTime",
 					 	timePeriod: "2016-03-07T19:20:00.000Z 2016-03-09T04:00:00.000Z"
					 }
				  },
				  responseFormat: "application/json"
			    })

service.send { |response| File.new("./response/tmp", "w").write response }
```	

### filter

simple tag with value

```ruby
service.filter({  offering: "name" }) # <sos:offering>name</sos:offering>

```

concate together

```ruby
service.filter({  offering: "name" })
	   .filter({  offering: "b" })
	   .filter({  offering: "c" })
       .filter({  offering: "d" })

# <sos:offering>name</sos:offering>
# <sos:offering>b</sos:offering>
# <sos:offering>c</sos:offering>
# <sos:offering>d</sos:offering>

```

complicate example

```ruby
service.filter({ offering: "offering", 
				 observedProperty: "observedProperty",
				 responseFormat: list[:responseFormat][0]})

```



## Contact A Human

Zil k471352@gmail.com