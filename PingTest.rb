require_relative 'lib/avalara/TaxSvc'

# Header Level Elements
# Required Header Level Elements
accountNumber = "1234567890"
licenseKey = "A1B2C3D4E5F6G7H8"
serviceURL = "https://development.avalara.net"

taxSvc = TaxSvc.new(accountNumber, licenseKey, serviceURL);

pingResult = taxSvc.Ping

#Display the result
puts "PingTest ResultCode: "+ pingResult["ResultCode"]
if pingResult["ResultCode"] != "Success"
  pingResult["Messages"].each { |message| puts message["Summary"] }
end
