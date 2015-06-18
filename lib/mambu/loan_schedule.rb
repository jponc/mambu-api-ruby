module Mambu
  class LoanSchedule < ApiModel
    attr_accessor :repayments

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

    def self.handle_error(response)
      return if response.success?
      error = response.error
      if error.status == 'INTERNAL_SERVER_ERROR'
        error = Mambu::Error.new(
          'Known mambu issue. Please grant administrator permissions to api user.'
        )
      end
      fail error
    end

    def self.camelize_hash(options)
      Hash[options.map { |k, v| [k.to_s.camelize(:lower).to_sym, v] }]
    end
  end
end
