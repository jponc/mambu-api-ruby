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

  describe "#convert_decimal" do
    let(:instance) { described_class.new({}) }

    context "value is not a string" do
      it "returns value" do
        expect(instance.convert_decimal(['array'])).to eq ['array']
      end
    end

    context "value is non-string number" do
      it "returns value" do
        expect(instance.convert_decimal(1)).to eq 1
      end
    end

    context "value non-numerical string" do
      it "returns value" do
        expect(instance.convert_decimal('nan')).to eq 'nan'
      end
    end

    context "value numerical string" do
      it "returns decimal value" do
        expect(instance.convert_decimal('13.23')).to eq BigDecimal.new('13.23')
      end
    end
  end
end
