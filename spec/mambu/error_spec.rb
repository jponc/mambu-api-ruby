require 'spec_helper'

describe Mambu::Error do
  let(:message) { 'Error message' }
  let(:code) { '123' }
  let(:status) { 'ERROR_MESSAGE' }
  subject { described_class.new(message, code, status) }

  it "can be created" do
    expect(subject).to be_kind_of described_class
  end

  it "is an error" do
    expect(subject).to be_kind_of StandardError
  end

  it "calls superclass message" do
    expect(subject.message).to eq 'Error message'
  end

  it 'sets code' do
    expect(subject.code).to eq '123'
  end

  it 'sets status' do
    expect(subject.status).to eq 'ERROR_MESSAGE'
  end
end
