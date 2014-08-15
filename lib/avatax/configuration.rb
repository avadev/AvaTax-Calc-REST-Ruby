require 'singleton'

module AvaTax
  class Configuration
    include Singleton

    def initialize
      @account_number = ENV['AVATAX_ACCOUNT_NUMBER']
      @license_key = ENV['AVATAX_LICENSE_KEY']
      @service_url = ENV['AVATAX_SERVICE_URL']
      super
    end

    def account_number(acct_num = nil)
      return @account_number if @account_number and acct_num.nil?
      @account_number = acct_num
    end

    def license_key(license = nil)
      return @license_key if @license_key and license.nil?
      @license_key = license
    end

    def service_url(url = nil)
      return @service_url if @service_url and url.nil?
      @service_url = url
    end
  end
end
