require_relative 'lib/avalara'

# Header Level Elements
# Required Header Level Elements
accountNumber = "1234567890"
licenseKey = "A1B2C3D4E5F6G7H8"
serviceURL = "https://development.avalara.net"

addressSvc = Avalara::AddressService.new(accountNumber, licenseKey, serviceURL);

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
validateResult = addressSvc.Validate(validateRequest)

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
