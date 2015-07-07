module Mambu
  class LoanSchedule < ApiModel
    attr_accessor :repayments
    extend Mambu::Helpers

    def repayments=(data)
      @repayments = data.map { |hash_fee| Mambu::Repayment.new(hash_fee) }
    end

    def self.find(loan_product, options, connection)
      response = connection.get(
        "#{endpoint(connection)}/#{loan_product.id}/schedule",
        camelize_hash(options)
      )
      handle_error(response)
      new(response.body)
    end

    def self.api_uri
      Mambu::LoanProduct.api_uri
    end
  end
end
