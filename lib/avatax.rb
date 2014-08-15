require_relative 'avatax/configuration'
module AvaTax

  def self.configure(&block)
    Configuration.instance.instance_eval(&block)
  end

  def self.configure_from(yaml_file)
    require 'yaml'
    config = YAML.load_file yaml_file
    configure do
      account_number config['account_number']
      license_key config['license_key']
      service_url config['service_url']
    end
  end

end
require_relative 'avatax/tax_service'
require_relative 'avatax/address_service'
