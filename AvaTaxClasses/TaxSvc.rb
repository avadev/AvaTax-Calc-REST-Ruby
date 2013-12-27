require 'json'
require 'net/http'
require 'addressable/uri'
require 'base64'
require 'rest-client'

class TaxSvc
  @@service_path = "/1.0/tax/"
  attr_accessor :account_number
  attr_accessor :license_key
  attr_accessor :service_url
  
  def initialize(account_number, license_key, service_url)
    @account_number = account_number
    @license_key = license_key
    @service_url = service_url
  end
  
  def CalcTax(request_hash)
    uri = @service_url + @@service_path + "get"
    cred = 'Basic '+ Base64.encode64(@account_number + ":"+ @license_key)
    res = RestClient.post uri, JSON.generate(request_hash), :authorization => cred
    JSON.parse(res.body)
  end
  
  
  def CancelTax(request_hash)
    uri = @service_url + @@service_path + "cancel"
    cred = 'Basic '+ Base64.encode64(@account_number + ":"+ @license_key)
    res = RestClient.post uri, JSON.generate(request_hash), :authorization => cred
    JSON.parse(res.body)["CancelTaxResult"] 
    #You may notice that this is slightly different from CalcTax, etc. The CancelTax result is  nested in this result object - this makes it consumable in a way that is consistant with the other response formats.
  end
  
  def EstimateTax(coordinates, sale_amount)
    # coordinates should be a hash with latitude and longitude
    # sale_amount should be a decimal
    return nil if coordinates.nil?
    sale_amount = 0 if sale_amount.nil?
    uri = URI(@service_url + @@service_path  + 
      coordinates[:latitude].to_s + "," + coordinates[:longitude].to_s + 
      "/get?saleamount=" + sale_amount.to_s )
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    cred = 'Basic '+ Base64.encode64(@account_number + ":"+ @license_key)
    res = http.get(uri.request_uri, 'Authorization' => cred)
    JSON.parse(res.body)
  end
  
  def Ping
    #There is no actual ping in the REST API, so this is a mockup that calls EstimateTax with 
    #hardcoded values.
    self.EstimateTax(
        { :latitude => "47.627935", 
          :longitude => "-122.51702"},
          0 )
  end
  
end