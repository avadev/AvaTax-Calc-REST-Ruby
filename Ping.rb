require_relative 'AvaTaxClasses/TaxSvc'

#Create an instance of the service class
svc = TaxSvc.new(
  "username", 
  "password",  
  "https://development.avalara.net"
  )

  #Call the service
result = svc.Ping

#Display the result
print "Ping ResultCode: "+result["ResultCode"]+"\n"

#If we encountered an error
if result["ResultCode"] != "Success"
  #Print the first error message returned
  print result["Messages"][0]["Summary"]+"\n"
end