require_relative 'AvaTaxClasses/TaxSvc'
require 'date'

#Create an instance of the service class
svc = TaxSvc.new(
  "username", 
  "password",  
  "https://development.avalara.net"
  )
  
  #Create the request
  #Document Level Setup  
  #             R: indicates Required Element
  #             O: Indicates Optional Element
  #
  calc_tax_request = {
      # Set the tax document properties - Required unless noted as Optional
      :CompanyCode => "DEFAULT",                          # R: Company Code from the accounts Admin Console
      :Client => "AvaTaxCalcRESTruby Sample",         # R: Identifies the software client initiating the webservice call               
      :DocCode =>"SampleDoc: " + DateTime.now.to_s,   # R: Invoice or document tracking number - Must be unique
      :DocType => "SalesInvoice",                     # R: Typically SalesOrder,SalesInvoice, ReturnInvoice
      :DocDate => DateTime.now.strftime("%Y-%m-%d"),  # R: Sets reporting date and default tax date
      :CustomerCode => "TaxSvcTest",                  # R: String - Customer Tracking number or Exemption Customer Code
      :DetailLevel => "Tax",                          # R: Chose Summary, Document, Line or Tax - varying levels of results detail 
      :Commit => false,                               # O: Default is "false" - Set to "true" to commit the Document
      #:CustomerUsageType => "G",                     # O: Send for tax exempt transactions only.
      #:ExemptionNo => "12334",                       # O: Send for tax exempt transactions only.
      #:Discount => 0,                                # O: Send for document-level discounts only.
      :PurchaseOrderNo => "PO 23423",                 # O: Specifies the purchase order number associated with the transaction. This value can be used to track single-use exemption certficates.
      :ReferenceCode => "",                           # O: This is a reportable value that does not affect tax calculation.
      :PosLaneCode => "",                             # O: This is a reportable value that does not affect tax calculation.
      #:TaxOverride => [{                             # O: Allows the TaxDate (or other values) to be overridden for tax calculation. Situational only.    
      #   :TaxOverrideType => "TaxDate",
      #   :Reason => "Credit Memo",
      #   :TaxDate => "2011-07-13",
      #   :TaxAmount => 0
      #}]                                        
      #:BusinessIdentificationNo => "",               # O: Specified VAT ID of customer for international/VAT calculations and reporting.
              
              
  #                  Begin Address Section
  #                  Add the origin and destination addresses referred to by the
  #                  "setOriginCode" and "setDestinationCode" properties above.

      :Addresses => [{
        :AddressCode => "Origin",
        :Line1 => "Avalara",
        :Line2 => "100 Ravine Lane NE",
        :Line3 => "Suite 220",
        :City => "Bainbridge Island",
        :Region => "WA",
        :PostalCode => "98110",
        :Country => "US"
        },
        {
        :AddressCode => "Dest",
        :Line1 => "7462 Kearny Street",
        :City => "Commerce City",
        :Region => "CO",
        :PostalCode => "80022",
        :Country => "US"    
        }],

    #
    # Alternate:  Latitude / Longitude addressing
    #                                   
    #   :Addresses => [{
    #   :AddressCode => "Origin",
    #   :Latitude => "47.6253",
    #   :Longitude => "-122.515114",
    #    },{
    #    :AddressCode => "Destination",
    #    :Latitude => "39.833597",
    #    :Longitude => "-104.917220"
    #    }],                  

  # End Address Section

      # Add invoice lines
  
      :Lines => [{                             
      :LineNo => "101",                               # R: string - line Number of invoice - must be unique.
      :ItemCode => "Item001",                         # R: string - SKU or short name of Item
      :Qty => 1,                                      # R: decimal - The number of items -- Qty of product sold.
      :Amount => 1000.00,                             # R: decimal - the "NET" amount -- Amount should be the 'extended' or 'net' amount
      #:CustomerUsageType => "G",                     # O: string - AKA Entity Use Code - Typically A - L 
      :Description => "ITEM1",                        # O: string - Description or category of item sold.
      :TaxCode => "",                                 # O: string - Pass standard, custom or Pro-Tax code
                                                      #             Can be NULL to default to tangible personal property =P0000000)
      :OriginCode => "Origin",                        # R: Value representing the Origin Address
      :DestinationCode => "Dest",                     # R: Value representing the Destination Address
      },{
      #Line 2 - Shipping/Freight line - See property descriptions above
      :LineNo => "102",                               # R: string - SKU or short name of Item
      :ItemCode => "Shipping",                        # R: string - SKU or short name of Item
      :Description => "Shipping- Freight Charges",    # O: string - Description or category of item sold.
      :Qty => 1,                                      # R: decimal - The number of items -- Qty of product sold. Does not function as a mulitplier for Amount
      :Amount => 10.00,                               # R: decimal - the "NET" amount -- Amount should be the 'extended' or 'net' amount
      :TaxCode => "FR",                               # O: string - Pass standard, custom or Pro-Tax code FR020100
      :OriginCode => "Origin",                        # R: Value representing the Origin Address
      :DestinationCode => "Dest",                     # R: Value representing the Destination Address
      }]
    }
  #Call the service
result = svc.CalcTax(calc_tax_request)

#Display the result
print "CalcTax ResultCode: "+result["ResultCode"]+"\n"

#If we encountered an error
if result["ResultCode"] != "Success"
  #Print the first error message returned
  print result["Messages"][0]["Summary"]+"\n"
else
  print "DocCode: " + result["DocCode"]+ " Total Tax Calculated: " + result["TotalTax"].to_s + "\n"
  print "Jurisdiction Breakdown:\n"
  #Show the tax amount calculated at each jurisdictional level
  result["TaxLines"].each do |line|
    print "   "
    print "Line Number " + line["LineNo"]+ ": Tax: " + line["Tax"]
    print "\n"
    line["TaxDetails"].each do |detail| 
      print "       "
      print detail["JurisName"]+ ": " +detail["Tax"].to_s 
      print "\n"
    end
  end
end
