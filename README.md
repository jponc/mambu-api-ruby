# Mambu

Wrapper for Mambu Cloud Banking Platform REST API

https://developer.mambu.com/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mambu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mambu

## Usage
    # create api connection
    connection = Mambu::Connection.new('username', 'password', 'tenant.sandbox')

### API models finders
##### #find_all
    Mambu::LoanProduct.find_all(connection)
    # or
    connection.loan_product.find_all
##### #find
    Mambu::LoanProduct.find('product_id', connection)
    # or
    connection.loan_product.find('product_id')

### Loan schedule
    options = {
      loan_amount: '10000',
      first_repayment_date: '2015-06-15',
      anticipated_disbursement: '2015-06-15',
      interest_rate: '15',
      repayment_installments: '12',
      repayment_period_unit: 'MONTHS',
      repayment_period_count: '1',
      principal_repayment_interval: '1'
    }
    Mambu::Schedule.find(loan_product, options, connection)

#### Implemented models:
Mambu::LoanProduct https://developer.mambu.com/customer/portal/articles/1616164-loan-products-api
Mambu::LoanSchedule https://developer.mambu.com/customer/portal/articles/1616164-loan-products-api


## Development

#### Gem development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

#### Mambu::ApiModel
Adding new api models is extremely easy. Model fields (accessors) are set dynamically based on json content. To add User model you have to:

    # create user class (lib/mambu/user.rb) that inherits from Mambu::ApiModel

    module Mambu
      class User < ApiModel
      end
    end

    # require this class in lib/mambu.rb
    require 'mambu/user'

Api endpoint is created from connection and model class name. For Mambu::User is is users. You can override this by setting class method api_uri

    module Mambu
      class User < ApiModel
        def self.api_uri
        'endpoint'
      end
      end
    end

You can also override accessor if you want to change how json data is converted into api model. For example:

    module Mambu
      class LoanProduct < ApiModel
        attr_accessor :loan_fees

        def loan_fees=(data)
          @loan_fees = data.map { |hash_fee| Mambu::LoanFee.new(hash_fee) }
        end
      end
    end

#### Mambu::Response
Every response is wrapped in Mambu::Response. This class converts json body to ruby hash with symbolized, snake_cased keys. It also reads mambu #error_code and #error_status from failed response body.

#### Mambu::Error
Mambu error has message, code and status. It can be generated from failed Mambu::Response by calling #error method. Message is humanized mambu error status.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/netguru/mambu-api-ruby.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
