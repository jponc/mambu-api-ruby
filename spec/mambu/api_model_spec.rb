require 'spec_helper'

describe Mambu::ApiModel do
  let(:connection) { Mambu::Connection.new('user', 'password', 'tenant.sandbox') }

  describe "#endpoint" do
    it "returns full api endpoint" do
      allow(described_class).to receive(:api_uri).and_return('objects')
      expect(described_class.endpoint(connection)).to eq 'https://tenant.sandbox.mambu.com/api/objects'
    end
  end

  describe "#api_uri" do
    it "returns api uri based on class name" do
      expect(described_class.api_uri).to eq 'apimodels'
    end
  end
end
