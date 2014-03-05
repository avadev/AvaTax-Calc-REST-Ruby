require_relative 'AvaTaxClasses/AddressSvc'

#Create an instance of the service class
svc = AddressSvc.new(
  "username", 
  "password",  
  "https://development.avalara.net"
  )
  
  # Create the request
input = {
  :Line1 => "General Delivery", #Required
  :Line2 => "Suite 100",        #Optional
  :Line3 => "Attn: Accounts Payable", #Optional
  :City =>"Seattle",            #Required, if PostalCode is not specified
  :Region=>"WA",                #Required, if PostalCode is not specified
  :PostalCode =>"98101",        #Required, if City and Region are not specified
  :Country => "US"              #Optional
}
#Call the service
result = svc.Validate(input)
#Display the result
print "Address Validation ResultCode: "+result["ResultCode"]+"\n"

#If we encountered an error
if result["ResultCode"] != "Success"
  #Print the first error message returned
  print result["Messages"][0]["Summary"]+"\n"
else
  print "Validated Address: \n"
  result["Address"].each do |key, value|
    print key + ": " + value +"\n"
  end
  
end
