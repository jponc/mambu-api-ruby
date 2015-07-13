require 'spec_helper'

describe Mambu::Repayment do
  subject { described_class.new(principal_due: '1000', interest_due: '0', fees_due: '150') }

  it "#payment_due" do
    expect(subject.payment_due).to eq BigDecimal.new(1150)
  end
end
