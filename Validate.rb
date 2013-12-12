require_relative 'AvaTaxClasses/AddressSvc'

svc = AddressSvc.new(
  "username", 
  "password",  
  "https://development.avalara.net"
  )
input = {
  :Line1 => "General Delivery", 
  :City =>"Seattle", 
  :Region=>"WA", 
  :PostalCode =>"98101"
}
result = svc.Validate(input)
print result
