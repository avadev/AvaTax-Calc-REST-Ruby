require_relative 'AvaTaxClasses/TaxSvc'

svc = TaxSvc.new(
  "username", 
  "password", 
  "https://development.avalara.net"
  )

calc_result = svc.CalcTax
cancel_result = svc.CancelTax
print result