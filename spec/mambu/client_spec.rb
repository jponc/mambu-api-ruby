require 'spec_helper'

describe Mambu::Client do
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:tenant) { 'tenant.sandbox' }
  let(:client) { described_class.new(username, password, tenant) }

  it 'exists' do
    expect(client).to be_kind_of(described_class)
  end

  describe '#valid?' do
    context 'has valid params' do
      it 'is valid' do
        expect(client.valid?).to eq true
      end
    end

    context 'has invalid params' do
      let(:username) { '' }

      it 'raises InsufficientCredentialsError' do
        expect { client }.to raise_error Mambu::InsufficientCredentialsError
      end
    end
  end

  describe '#connection' do
    it "is a faraday connection" do
      expect(client.connection).to be_kind_of(Faraday::Connection)
    end

    it "has basic auth setup" do
      expect(client.connection.headers['Authorization']).not_to be_nil
    end
  end

  describe '#api_url' do
    it 'returns correct api base url' do
      expect(client.api_url).to eq 'https://tenant.sandbox.mambu.com/api'
    end
  end
end
