require 'spec_helper'

describe Mambu::Finders do
  let(:connection) { Mambu::Connection.new('user', 'password', 'tenant.sandbox') }
  let(:extended_class) { Mambu::ApiModel.extend Mambu::Finders }

  describe "#find_all" do
    context "endpoint exists" do
      before { allow(extended_class).to receive(:api_uri).and_return('loanproducts') }

      it "returns array of resource", :vcr do
        expect(extended_class.find_all(connection)).to be_kind_of Array
      end

      it "returns api models", :vcr do
        expect(extended_class.find_all(connection).first).to be_kind_of extended_class
      end
    end

    context "endpoint doesn't exist" do
      before { allow(extended_class).to receive(:api_uri).and_return('non-existing-endpoint') }

      it "raises invalid api operation mambu error", :vcr do
        expect { extended_class.find_all(connection) }
          .to raise_error Mambu::Error, "Invalid api operation"
      end
    end
  end

  describe "#find" do
    context "endpoint exists" do
      before { allow(extended_class).to receive(:api_uri).and_return('loanproducts') }

      context "resource exists" do
        it "returns api model", :vcr do
          expect(extended_class.find('product_id', connection)).to be_kind_of extended_class
        end
      end

      context "resource doesn't exist" do
        it "raises invalid product id mambu error", :vcr do
          expect { extended_class.find('non-existing-product', connection) }
            .to raise_error Mambu::Error, "Invalid product id"
        end
      end
    end

    context "endpoint doesn't exist" do
      before { allow(extended_class).to receive(:api_uri).and_return('non-existing-endpoint') }

      it "raises invalid api operation mambu error", :vcr do
        expect { extended_class.find('product_id', connection) }
          .to raise_error Mambu::Error, "Invalid api operation"
      end
    end
  end

end
