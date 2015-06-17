require 'spec_helper'

describe Mambu::Response do
  let(:connection) { Mambu::Connection.new('user', 'password', 'tenant.sandbox') }
  subject { described_class.new(faraday_response) }

  context "success" do
    let(:faraday_response) { connection.connection.get("#{connection.api_url}/loanproducts") }

    it "creates response" do
      VCR.use_cassette("mambu/response/success") do
        expect(subject).to be_kind_of described_class
      end
    end

    it "sets faraday response" do
      VCR.use_cassette("mambu/response/success") do
        expect(subject.faraday_response).to eq faraday_response
      end
    end

    it "sets http status" do
      VCR.use_cassette("mambu/response/success") do
        expect(subject.http_status).to eq faraday_response.status
      end
    end

    describe "#success?" do
      it "is success" do
        VCR.use_cassette("mambu/response/success") do
          expect(subject.success?).to eq true
        end
      end
    end

    describe "#error" do
      it "returns nil" do
        VCR.use_cassette("mambu/response/success") do
          expect(subject.error).to be_nil
        end
      end
    end

    describe "#parse_body" do
      let(:json) do
        '{
          "encodedKey":"key",
          "id":"product_id",
          "repaymentAllocationOrder":["FEE","PENALTY","INTEREST","PRINCIPAL"],
          "loanFees":[
            {"encodedKey":"key"},
            {"encodedKey":"key"}
          ]
        }'
      end
      let(:parsed_json) do
        {
          encoded_key: 'key',
          id: 'product_id',
          repayment_allocation_order: %w{FEE PENALTY INTEREST PRINCIPAL},
          loan_fees: [
            { encoded_key: 'key' },
            { encoded_key: 'key' }
          ]
        }
      end
      it "sets body as parsed json", :vcr do
        allow(faraday_response).to receive(:body).and_return(json)
        expect(subject.body).to eq parsed_json
      end
    end
  end

  context "mambu failure" do
    let(:faraday_response) { connection.connection.get("#{connection.api_url}/fake-endpoint/") }

    it "creates response" do
      VCR.use_cassette("mambu/response/mambu_failure") do
        expect(subject).to be_kind_of described_class
      end
    end

    it "sets error code" do
      VCR.use_cassette("mambu/response/mambu_failure") do
        expect(subject.error_code).to eq 3
      end
    end

    it "sets error status" do
      VCR.use_cassette("mambu/response/mambu_failure") do
        expect(subject.error_status).to eq 'INVALID_API_OPERATION'
      end
    end

    describe "#error_message" do
      it "creates humanized error message from error status" do
        VCR.use_cassette("mambu/response/mambu_failure") do
          expect(subject.error_message).to eq 'Invalid api operation'
        end
      end
    end

    describe "#success?" do
      it "is not success" do
        VCR.use_cassette("mambu/response/mambu_failure") do
          expect(subject.success?).to eq false
        end
      end
    end

    describe "#error" do
      it "returns mambu error" do
        VCR.use_cassette("mambu/response/mambu_failure") do
          expect(subject.error).to be_kind_of Mambu::Error
        end
      end

      it "sets errors code" do
        VCR.use_cassette("mambu/response/mambu_failure") do
          expect(subject.error.code).to eq 3
        end
      end

      it "has errors status" do
        VCR.use_cassette("mambu/response/mambu_failure") do
          expect(subject.error.status).to eq 'INVALID_API_OPERATION'
        end
      end

      it "has errors message" do
        VCR.use_cassette("mambu/response/mambu_failure") do
          expect(subject.error.message).to eq 'Invalid api operation'
        end
      end
    end
  end
end
