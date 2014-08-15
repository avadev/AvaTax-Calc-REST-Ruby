avatax.rb
=====================

This is a Ruby client library for the [AvaTax REST API](http://developer.avalara.com/api-docs/rest)
methods:
[tax/get POST](http://developer.avalara.com/api-docs/rest/tax/post/),
[tax/get GET](http://developer.avalara.com/api-docs/rest/tax/get),
[tax/cancel POST](http://developer.avalara.com/api-docs/rest/tax/cancel), and
[address/validate GET](http://developer.avalara.com/api-docs/rest/address-validation).

For more information on the use of these methods and the AvaTax product, please
visit our [developer site](http://developer.avalara.com/) or [homepage](http://www.avalara.com/)

Dependencies
-----------
- Ruby 1.9.2 or later
- [Bundler](http://bundler.io)

Requirements
----------
- Add the `avatax` gem to your Gemfile with `gem 'avatax'`
- Run `bundle install` to retrieve `avatax` and all its dependencies
- Authentication requires an valid **Account Number** and **License Key**. If you do not have an AvaTax account, a free trial account can be acquired through our [developer site](http://developer.avalara.com/api-get-started)
- Specify your authentication credentials as
  - environment variables,
  - YAML file (see `credentials.yml.example`), or
  - in source

Credentials as environment variables
------------------------------------
```shell
$ AVATAX_ACCOUNT_NUMBER=1234567890 AVATAX_LICENSE_KEY=A1B2C3D4E5F6G7H8 AVATAX_SERVICE_URL=https://development.avalara.net bundle exec ruby examples/PingTest.rb
```

Credentials from YAML file
--------------------------
```ruby
AvaTax.configure_from 'credentials.yml.example'
```

Credentials in source
---------------------
```ruby
AvaTax.configure do
  account_number '1234567890'
  license_key 'A1B2C3D4E5F6G7H8'
  service_url 'https://development.avalara.net'
end
```

Examples
--------

| Filename           | Description |
| :----------------- | :---------- |
| CancelTaxTest.rb   | Demonstrates [AvaTax::TaxService.cancel](http://developer.avalara.com/api-docs/rest/tax/cancel) used to [void a document](http://developer.avalara.com/api-docs/api-reference/canceltax) |
| EstimateTaxTest.rb | Demonstrates the [AvaTax::TaxService.estimate](http://developer.avalara.com/api-docs/rest/tax/get) method used for product- and line- indifferent tax estimates. |
| GetTaxTest.rb      | Demonstrates the [AvaTax::TaxService.get](http://developer.avalara.com/api-docs/rest/tax/post) method used for product- and line- specific [calculation](http://developer.avalara.com/api-docs/api-reference/gettax). **NOTE:** This will generate a new transaction/document each time. |
| PingTest.rb        | Uses a hardcoded `AvaTax::TaxService.estimate` call to test connectivity and credential information. |
| ValidateTest.rb    | Demonstrates the [AvaTax::AddressService.validate](http://developer.avalara.com/api-docs/rest/address-validation) method to [normalize an address](http://developer.avalara.com/api-docs/api-reference/address-validation). |
