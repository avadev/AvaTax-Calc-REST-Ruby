require 'avatax'

# Header Level Elements
# Required Header Level Elements
accountNumber = "1234567890"
licenseKey = "A1B2C3D4E5F6G7H8"
serviceURL = "https://development.avalara.net"

taxSvc = AvaTax::TaxService.new(accountNumber, licenseKey, serviceURL);

getTaxRequest = {
  # Document Level Elements
  # Required Request Parameters
  :CustomerCode => "ABC4335",
  :DocDate => "2014-01-01",

  # Best Practice Request Parameters
  :CompanyCode => "APITrialCompany",
  :Client => "AvaTaxSample",
  :DocCode => "INV001",
  :DetailLevel => "Tax",
  :Commit => false,
  :DocType => "SalesInvoice",

  # Situational Request Parameters
  # :CustomerUsageType => "G",
  # :ExemptionNo => "12345",
  # :Discount => 50,
  # :TaxOverride => 
  # [{
  #   :TaxOverrideType => "TaxDate",
  #   :Reason => "Adjustment for return",
  #   :TaxDate => "2013-07-01",
  #   :TaxAmount => 0,
  # }],

  # Optional Request Parameters
  :PurchaseOrderNo => "PO123456",
  :ReferenceCode => "ref123456",
  :PosLaneCode => "09",
  :CurrencyCode => "USD",

  # Address Data
  :Addresses =>
  [
    {
      :AddressCode => "01",
      :Line1 => "45 Fremont Street",
      :City => "San Francisco",
      :Region => "CA",
    },
    {
      :AddressCode => "02",
      :Line1 => "118 N Clark St",
      :Line2 => "Suite 100",
      :Line3 => "ATTN Accounts Payable",
      :City => "Chicago",
      :Region => "IL",
      :Country => "US",
      :PostalCode => "60602",
    },
    {
      :AddressCode => "03",
      :Latitude => "47.627935",
      :Longitude => "-122.51702",
    }
  ],

  # Line Data
  :Lines =>
  [
    {
    # Required Parameters
    :LineNo => "01",
    :ItemCode => "N543",
    :Qty => 1,
    :Amount => 10,
    :OriginCode => "01",
    :DestinationCode => "02",

    # Best Practice Request Parameters
    :Description => "Red Size 7 Widget",
    :TaxCode => "NT",

    # Situational Request Parameters
    # :CustomerUsageType => "L",
    # :Discounted => true,
    # :TaxIncluded => true,
    # :TaxOverride => 
    # [{
    #   :TaxOverrideType => "TaxDate",
    #   :Reason => "Adjustment for return",
    #   :TaxDate => "2013-07-01",
    #   :TaxAmount => 0,
    # }],

    #Optional Request Parameters
    :Ref1 => "ref123",
    :Ref2 => "ref456",
    },
    {
    :LineNo => "02",
    :ItemCode => "T345",
    :Qty => 3,
    :Amount => 150,
    :OriginCode => "01",
    :DestinationCode => "03",
    :Description =>  "Size 10 Green Running Shoe",
    :TaxCode => "PC030147"
    },
    {
    :LineNo => "02-FR",
    :ItemCode => "FREIGHT",
    :Qty => 1,
    :Amount => 15,
    :OriginCode => "01",
    :DestinationCode => "03",
    :Description => "Shipping Charge",
    :TaxCode => "FR"
    }
  ]
}

getTaxResult = taxSvc.get(getTaxRequest)

# Print Results
puts "getTaxTest ResultCode: " + getTaxResult["ResultCode"]
if getTaxResult["ResultCode"] != "Success"
  getTaxResult["Messages"].each { |message| puts message["Summary"] }
else
  puts "Document Code: " + getTaxResult["DocCode"] + " Total Tax: " + getTaxResult["TotalTax"].to_s
  getTaxResult["TaxLines"].each do |taxLine|
      puts "    " + "Line Number: " + taxLine["LineNo"] + " Line Tax: " + taxLine["Tax"].to_s
      taxLine["TaxDetails"].each do |taxDetail|
          puts "        " + "Jurisdiction: " + taxDetail["JurisName"] + " Tax: " + taxDetail["Tax"].to_s
      end
  end
end
