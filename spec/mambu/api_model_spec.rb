require 'spec_helper'

describe Mambu::ApiModel do
  let(:client) { Mambu::ApiClient.new('user', 'password', 'tenant.sandbox') }

  describe "#endpoint" do
    it "returns full api endpoint" do
      allow(described_class).to receive(:api_uri).and_return('objects')
      expect(described_class.endpoint(client)).to eq 'https://tenant.sandbox.mambu.com/api/objects'
    end
  end

  describe "#find_all" do
    context "endpoint exists" do
      it "returns array of resource", :vcr do
        allow(described_class).to receive(:api_uri).and_return('loanproducts')
        expect(described_class.find_all(client)).to be_kind_of Array
      end
    end

    context "endpoint doesn't exist" do
    end
  end

  describe "#find" do
    context "resource exist" do
    end

    context "resource doesn't exist" do
    end

    context "endpoint doesn't exist" do
    end
  end
end
