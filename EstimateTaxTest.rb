require_relative 'AvaTaxClasses/TaxSvc'

# Header Level Elements
# Required Header Level Elements
accountNumber = "1234567890"
licenseKey = "A1B2C3D4E5F6G7H8"
serviceURL = "https://development.avalara.net"

taxSvc = TaxSvc.new(accountNumber, licenseKey, serviceURL);
  
#Required Request Parameters
location = {
  :Latitude => "47.627935", 
  :Longitude => "-122.51702"
}
saleAmount = 10

# Call the service
geoTaxResult = taxSvc.EstimateTax(location, saleAmount)

# Print Results
puts "EstimateTaxTest ResultCode: "+geoTaxResult["ResultCode"]
if geoTaxResult["ResultCode"] != "Success"
  geoTaxResult["Messages"].each { |message| puts message["Summary"] }
else
  puts "Total Rate: " + geoTaxResult["Rate"].to_s + " Total Tax: " + geoTaxResult["Tax"].to_s
  #Show the tax amount calculated at each jurisdictional level
  geoTaxResult["TaxDetails"].each do |taxDetail| 
    puts "   " + "Jurisdiction: " + taxDetail["JurisName"] + " Tax: " + taxDetail["Tax"].to_s 
  end
end
