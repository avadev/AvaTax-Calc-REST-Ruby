require 'avatax'

# Header Level Elements
# Required Header Level Elements
AvaTax.configure_from 'credentials.yml'

addressSvc = AvaTax::AddressService.new

validateRequest = {
  # Required Request Parameters
   :Line1 => "118 N Clark St",
   :City => "Chicago",
   :Region => "IL",
  # Optional Request Parameters
   :Line2 => "Suite 100",
   :Line3 => "ATTN Accounts Payable",
   :Country => "US",
   :PostalCode => "60602"
}

# Call the service
validateResult = addressSvc.validate(validateRequest)

# Print Results
puts "ValidateAddressTest Result: "+validateResult["ResultCode"]
if validateResult["ResultCode"] != "Success"
  validateResult["Messages"].each { |message| puts message["Summary"] }
else
  puts validateResult["Address"]["Line1"] +
  " " +
  validateResult["Address"]["City"] +
  ", " +
  validateResult["Address"]["Region"] +
  " " +
  validateResult["Address"]["PostalCode"]
end
