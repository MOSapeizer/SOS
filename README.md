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

list[:offering] # list all offerings of the SOS service 

```

### GetObservation

	


## Contact A Human

Zil k471352@gmail.com