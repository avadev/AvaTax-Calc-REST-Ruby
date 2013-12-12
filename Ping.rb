require_relative 'AvaTaxClasses/TaxSvc'

svc = TaxSvc.new(
  "username", 
  "password",  
  "https://development.avalara.net"
  )

result = svc.Ping
print result