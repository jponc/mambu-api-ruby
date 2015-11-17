module Mambu
  module LoanHelpers
    def loans
      Mambu::Loan.find_all(self)
    end

    def create_loan(loan_attrs, custom_infos)
      custom_infos =
        custom_infos.map do |k, v|
          {customFieldID: k.to_s, value: v}
        end
      data = { loanAccount: loan_attrs, customInformation: custom_infos }
      Mambu::Loan.create_loan(self, data)
    end
  end
end
