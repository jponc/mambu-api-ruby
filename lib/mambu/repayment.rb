module Mambu
  class Repayment < ApiModel
    def payment_due
      principal_due + interest_due + fees_due
    end
  end
end
