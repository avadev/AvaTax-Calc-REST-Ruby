require 'avatax'

# Header Level Elements
# Required Header Level Elements
AvaTax.configure_from 'credentials.yml'

taxSvc = AvaTax::TaxService.new

pingResult = taxSvc.ping

#Display the result
puts "PingTest ResultCode: "+ pingResult["ResultCode"]
if pingResult["ResultCode"] != "Success"
  pingResult["Messages"].each { |message| puts message["Summary"] }
end
