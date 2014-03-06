require_relative 'AvaTaxClasses/TaxSvc'

# Header Level Elements
# Required Header Level Elements
accountNumber = "1234567890"
licenseKey = "A1B2C3D4E5F6G7H8"
serviceURL = "https://development.avalara.net"

taxSvc = TaxSvc.new(accountNumber, licenseKey, serviceURL);

getTaxRequest = {
  # Document Level Elements
  # Required Request Parameters
  :customerCode => "ABC4335",
  :docDate => "2014-01-01",

  # Best Practice Request Parameters
  :companyCode => "APITrialCompany",
  :Client => "AvaTaxSample",
  :docCode => "INV001",
  :detailLevel => "Tax",
  :commit => false,
  :docType => "SalesInvoice",

  # Situational Request Parameters
  # :customerUsageType => "G",
  # :exemptionNo => "12345",
  # :discount => 50,
  # :taxOverride => 
  # [{
  #   :taxOverrideType => "TaxDate",
  #   :reason => "Adjustment for return",
  #   :taxDate => "2013-07-01",
  #   :taxAmount => 0,
  # }],
  
  # Optional Request Parameters
  :purchaseOrderNo => "PO123456",
  :referenceCode => "ref123456",
  :posLaneCode => "09",
  :currencyCode => "USD",

  # Address Data
  :addresses => 
  [
    {
      :addressCode => "01",
      :line1 => "45 Fremont Street",
      :city => "San Francisco",
      :region => "CA",
    },
    {
      :addressCode => "02",
      :line1 => "118 N Clark St",
      :line2 => "Suite 100",
      :line3 => "ATTN Accounts Payable",
      :city => "Chicago",
      :region => "IL",
      :country => "US",
      :postalCode => "60602",
    },
    {
      :addressCode => "03",
      :latitude => "47.627935",
      :longitude => "-122.51702",
    }
  ],

  # Line Data
  :lines => 
  [
    {
    # Required Parameters
    :lineNo => "01",
    :itemCode => "N543",
    :qty => 1,
    :amount => 10,
    :originCode => "01",
    :destinationCode => "02",

    # Best Practice Request Parameters
    :description => "Red Size 7 Widget",
    :taxCode => "NT",

    # Situational Request Parameters
    # :customerUsageType => "L",
    # :discounted => true,
    # :taxIncluded => true,
    # :taxOverride => 
    # [{
    #   :taxOverrideType => "TaxDate",
    #   :reason => "Adjustment for return",
    #   :taxDate => "2013-07-01",
    #   :taxAmount => 0,
    # }],

    #Optional Request Parameters
    :ref1 => "ref123",
    :ref2 => "ref456",
    },
    {
    :lineNo => "02",
    :itemCode => "T345",
    :qty => 3,
    :amount => 150,
    :originCode => "01",
    :destinationCode => "03",
    :description =>  "Size 10 Green Running Shoe",
    :taxCode => "PC030147"
    },
    {
    :lineNo => "02-FR",
    :itemCode => "FREIGHT",
    :qty => 1,
    :amount => 15,
    :originCode => "01",
    :destinationCode => "03",
    :description => "Shipping Charge",
    :taxCode => "FR"
    }
  ]
}

getTaxResult = taxSvc.GetTax(getTaxRequest)

# Print Results
puts "getTaxTest ResultCode: " + getTaxResult["ResultCode"]
if getTaxResult["ResultCode"] != "Success"
  getTaxResult["Messages"].each { |message| puts message["Summary"] }
else
  puts "Document Code: " + getTaxResult["DocCode"] + " Total Tax: " + getTaxResult["TotalTax"].to_s
  result["TaxLines"].each do |taxLine|
      puts "    " + "Line Number: " + taxLine["LineNo"] + " Line Tax: " + taxLine["Tax"].to_s
      taxLine["TaxDetails"].each do |taxDetail| 
          puts "        " + "Jurisdiction: " + taxDetail["JurisName"] + " Tax: " + taxDetail["Tax"].to_s
      end
  end
end