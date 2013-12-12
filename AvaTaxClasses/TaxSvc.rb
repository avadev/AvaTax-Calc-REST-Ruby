require 'json'
require 'net/http'
require 'addressable/uri'
require 'base64'

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
  
  def CalcTax
    
    body_hash = {
      :DocDate=>"2013-02-11", 
      :CustomerCode=>"0000", 
      :CompanyCode=>"SDK", 
      :DocType=>"SalesInvoice", 
      :Commit=>true, 
      :Addresses=>[{
        :AddressCode=>"1", 
        :Line1=>"435 Ericksen Avenue Northeast", 
        :Line2=>"#250", 
        :PostalCode=>"98110"}], 
      :Lines=>[{
        :LineNo=>"1", 
        :DestinationCode=>"1", 
        :OriginCode=>"1", 
        :Qty=>1, 
        :Amount=>10}]
      }
    uri = URI(@service_url + @@service_path  + "get")
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(body_hash)
    req.basic_auth @account_number, @license_key
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    res = nil
    http.start do |sock|
      res = sock.request(req)
    end
    JSON.parse(res.body)
  end
  
  
  def CancelTax
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