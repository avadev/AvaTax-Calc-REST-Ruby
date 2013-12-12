require_relative 'AvaTaxClasses/TaxSvc'

svc = TaxSvc.new(
  "username", 
  "password",  
  "https://development.avalara.net"
  )
location = {
  :latitude => "47.627935", 
  :longitude => "-122.51702"
}
sale_amount = 50.44
result = svc.EstimateTax(location, sale_amount)
print result