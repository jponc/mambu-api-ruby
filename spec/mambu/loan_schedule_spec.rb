require 'spec_helper'

describe Mambu::LoanSchedule do
  let(:connection) { Mambu::Connection.new('user', 'password', 'tenant.sandbox') }
  let(:loan_product) { double(id: 'product_id') }
  let(:options) do
    {
      loan_amount: '10000',
      first_repayment_date: '2015-06-15',
      anticipated_disbursement: '2015-06-15',
      interest_rate: '15',
      repayment_installments: '12',
      repayment_period_unit: 'MONTHS',
      repayment_period_count: '1',
      principal_repayment_interval: '1'
    }
  end
  subject { described_class.find(loan_product, options, connection) }

  context "api user is an admin" do
    context "valid options" do
      it "returns schedule", :vcr do
        expect(subject).to be_kind_of described_class
      end

      context "params inconsistent with product rules" do
        it "raises params inconsistent mambu error", :vcr do
          options[:loan_amount] = '100000'
          expect { subject }.to raise_error Mambu::Error, "Params inconsistent with product rules"
        end
      end
    end

    describe "#repayments=" do
      it "sets array of repayments", :vcr do
        expect(subject.repayments).to be_kind_of Array
      end

      it "has repayment objects", :vcr do
        expect(subject.repayments.first).to be_kind_of Mambu::Repayment
      end
    end

    context "invalid options" do
      let(:options) { { invalid: 'options' } }

      it "raises mambu error", :vcr do
        expect { subject }.to raise_error Mambu::Error
      end
    end
  end

  context "api user is not an admin" do
    it "returns known issue mambu error", :vcr do
      expect { subject }.to raise_error(
        Mambu::Error,
        'Known mambu issue. Please grant administrator permissions to api user.'
      )
    end
  end
end
