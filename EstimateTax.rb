require_relative 'AvaTaxClasses/TaxSvc'

#Create an instance of the service class
svc = TaxSvc.new(
  "username", 
  "password",  
  "https://development.avalara.net"
  )
  
  #Create the request
location = {
  :latitude => "47.627935",   #Required
  :longitude => "-122.51702"  #Required
}
sale_amount = 50.44           #Required

#Call the service
result = svc.EstimateTax(location, sale_amount)
#Display the result
print "EstimateTax ResultCode: "+result["ResultCode"]+"\n"

#If we encountered an error
if result["ResultCode"] != "Success"
  #Print the first error message returned
  print result["Messages"][0]["Summary"]+"\n"
end