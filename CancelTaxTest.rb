require_relative 'AvaTaxClasses/TaxSvc'

#Create an instance of the service class
svc = TaxSvc.new(
  "username", 
  "password",  
  "https://development.avalara.net"
  )
  
  #Create the request
  request = {
    :DocCode=>"2013-02-11",   #Required
    :CompanyCode=>"SDK",      #Required
    :DocType=>"SalesInvoice", #Required
    :CancelCode=>"DocDeleted" #Required
    }
  #Call the service
result = svc.CancelTax(request)

#Display the result
print "CancelTax ResultCode: "+result["ResultCode"]+"\n"

#If we encountered an error
if result["ResultCode"] != "Success"
  #Print the first error message returned
  print result["Messages"][0]["Summary"]+"\n"
end