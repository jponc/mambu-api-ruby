require 'spec_helper'

describe Mambu::Savings do
  let(:connection) { Mambu::Connection.new('user', 'password', 'tenant.sandbox') }
  let(:data) { { type: 'DEPOSIT', amount: 222 } }
  let(:account_id) { 'ABCD123' }

  context 'creating deposit' do
    let(:valid_transaction) do
      described_class.create_deposit(account_id, connection, data)
    end

    context 'valid transaction' do
      it 'returns a Mambu Savings object', :vcr do
        expect(valid_transaction).to be_kind_of described_class
      end

      it 'values of returned object match those from api', :vcr do
        object = valid_transaction
        expect(object.amount).to eq 222
        expect(object.type).to eq 'DEPOSIT'
      end
    end

    context 'invalid transaction' do
      let(:invalid_data) { data.merge(method: 'name') }
      let(:invalid_data_2) { data.merge('AccountName': 'Test Name') }
      let(:invalid_transaction) do
        described_class.create_deposit(account_id, connection, invalid_data)
      end
      let(:invalid_transaction_2) do
        described_class.create_deposit(account_id, connection, invalid_data_2)
      end

      it 'returns an error', :vcr do
        expect { invalid_transaction }.to raise_error Mambu::Error
      end

      it 'provides an error description', :vcr do
        expect { invalid_transaction }.to raise_error do |error|
          error.status == "INVALID_TRANSACTION_TYPE_ID"
        end
      end

      it 'doesnt allow any unnecessary attributes', :vcr do
        expect { invalid_transaction_2 }.to raise_error do |error|
          error.code == 108
        end
      end
    end
  end
end
