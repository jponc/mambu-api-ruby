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
      before { allow(described_class).to receive(:api_uri).and_return('loanproducts') }

      it "returns array of resource", :vcr do
        expect(described_class.find_all(client)).to be_kind_of Array
      end

      it "returns api models", :vcr do
        expect(described_class.find_all(client).first).to be_kind_of described_class
      end
    end

    context "endpoint doesn't exist" do
      before { allow(described_class).to receive(:api_uri).and_return('non-existing-endpoint') }

      it "raises EndpointNotFoundError", :vcr do
        expect { described_class.find_all(client) }
          .to raise_error Mambu::EndpointNotFoundError
      end
    end
  end

  describe "#find" do
    context "endpoint exists" do
      before { allow(described_class).to receive(:api_uri).and_return('loanproducts') }

      context "resource exists" do
        it "returns api model", :vcr do
          expect(described_class.find('product_id', client)).to be_kind_of described_class
        end
      end

      context "resource doesn't exist" do
        it "raises ModelNotFoundError", :vcr do
          expect { described_class.find('non-existing-product', client) }
            .to raise_error Mambu::ModelNotFoundError
        end
      end
    end

    context "endpoint doesn't exist" do
      before { allow(described_class).to receive(:api_uri).and_return('non-existing-endpoint') }

      it "raises EndpointNotFoundError", :vcr do
        expect { described_class.find('product_id', client) }
          .to raise_error Mambu::EndpointNotFoundError
      end
    end
  end
end
