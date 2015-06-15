require 'spec_helper'

describe Mambu::LoanProduct do
  let(:client) { Mambu::ApiClient.new('user', 'password', 'tenant.sandbox') }
  subject { described_class.find('product_id', client) }

  describe "#loan_fees=" do
    it "sets array of loan fees", :vcr do
      expect(subject.loan_fees).to be_kind_of Array
    end

    it "has loan fees objects", :vcr do
      expect(subject.loan_fees.first).to be_kind_of Mambu::LoanFee
    end
  end
end
