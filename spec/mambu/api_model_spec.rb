require 'spec_helper'

describe Mambu::ApiModel do
  let(:connection) { Mambu::Connection.new('user', 'password', 'tenant.sandbox') }

  describe "#endpoint" do
    it "returns full api endpoint" do
      allow(described_class).to receive(:api_uri).and_return('objects')
      expect(described_class.endpoint(connection)).to eq 'https://tenant.sandbox.mambu.com/api/objects'
    end
  end

  describe "#find_all" do
    context "endpoint exists" do
      before { allow(described_class).to receive(:api_uri).and_return('loanproducts') }

      it "returns array of resource", :vcr do
        expect(described_class.find_all(connection)).to be_kind_of Array
      end

      it "returns api models", :vcr do
        expect(described_class.find_all(connection).first).to be_kind_of described_class
      end
    end

    context "endpoint doesn't exist" do
      before { allow(described_class).to receive(:api_uri).and_return('non-existing-endpoint') }

      it "raises invalid api operation mambu error", :vcr do
        expect { described_class.find_all(connection) }
          .to raise_error Mambu::Error, "Invalid api operation"
      end
    end
  end

  describe "#find" do
    context "endpoint exists" do
      before { allow(described_class).to receive(:api_uri).and_return('loanproducts') }

      context "resource exists" do
        it "returns api model", :vcr do
          expect(described_class.find('product_id', connection)).to be_kind_of described_class
        end
      end

      context "resource doesn't exist" do
        it "raises invalid product id mambu error", :vcr do
          expect { described_class.find('non-existing-product', connection) }
            .to raise_error Mambu::Error, "Invalid product id"
        end
      end
    end

    context "endpoint doesn't exist" do
      before { allow(described_class).to receive(:api_uri).and_return('non-existing-endpoint') }

      it "raises invalid api operation mambu error", :vcr do
        expect { described_class.find('product_id', connection) }
          .to raise_error Mambu::Error, "Invalid api operation"
      end
    end
  end
end
