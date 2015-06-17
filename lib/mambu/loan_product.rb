module Mambu
  class LoanProduct < ApiModel
    attr_accessor :loan_fees

    def loan_fees=(data)
      @loan_fees = data.map { |hash_fee| Mambu::LoanFee.new(hash_fee) }
    end
  end
end
