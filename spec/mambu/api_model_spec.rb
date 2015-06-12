require 'spec_helper'

describe Mambu::ApiModel do
  let(:client) { Mambu::ApiClient.new('user', 'password', 'tenant.sandbox') }

  describe "#endpoint" do
    it "returns full api endpoint" do
      allow(described_class).to receive(:api_uri).and_return('objects')
      expect(described_class.endpoint(client)).to eq 'https://tenant.sandbox.mambu.com/api/objects'
    end
  end
end
