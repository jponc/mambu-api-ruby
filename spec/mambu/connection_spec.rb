require 'spec_helper'

describe Mambu::Connection do
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:tenant) { 'tenant.sandbox' }
  subject { described_class.new(username, password, tenant) }

  it 'exists' do
    expect(subject).to be_kind_of(described_class)
  end

  describe '#valid?' do
    context 'has valid params' do
      it 'is valid' do
        expect(subject.valid?).to eq true
      end
    end

    context 'has invalid params' do
      let(:username) { '' }

      it 'raises insufficient credentials mambu error' do
        expect { subject }.to raise_error Mambu::Error, 'Insufficient credentials'
      end
    end
  end

  describe '#connection' do
    it "is a faraday connection" do
      expect(subject.connection).to be_kind_of(Faraday::Connection)
    end

    it "has basic auth setup" do
      expect(subject.connection.headers['Authorization']).not_to be_nil
    end
  end

  describe '#api_url' do
    it 'returns correct api base url' do
      expect(subject.api_url).to eq 'https://tenant.sandbox.mambu.com/api'
    end
  end

  describe "#request" do
    let(:method) { :get }
    let(:url) { 'https://tenant.sandbox.mambu.com/api/loanproducts/' }
    let(:options) { { option1: 'value1', option2: 'value2' } }
    let(:request) { subject.request(method, url, options) }

    it "creates mambu response", :vcr do
      expect(request).to be_kind_of Mambu::Response
    end

    describe 'connection' do
      before { allow(Mambu::Response).to receive(:new).and_return(true) }
      it "calls method in connection" do
        expect_any_instance_of(Faraday::Connection).to receive(:get).with(url, options).once
        request
      end

      describe "#get" do
        it "calls get method on connection" do
          expect_any_instance_of(Faraday::Connection).to receive(:get).with(url, options).once
          subject.get(url, options)
        end
      end

      describe "#post" do
        it "calls post method on connection" do
          expect_any_instance_of(Faraday::Connection).to receive(:post).with(url, options).once
          subject.post(url, options)
        end
      end
    end
  end

  describe "#loan_product" do
    it "calls #find method on loan product" do
      allow(Mambu::LoanProduct).to receive(:find)
      expect(Mambu::LoanProduct).to receive(:find).with('product_id', subject).once
      subject.loan_product('product_id')
    end
  end

  describe "#loan_products" do
    it "calls #find_all method on loan product" do
      allow(Mambu::LoanProduct).to receive(:find_all)
      expect(Mambu::LoanProduct).to receive(:find_all).with(subject).once
      subject.loan_products
    end
  end
end
