$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mambu'
require 'vcr'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = example
           .metadata[:full_description]
           .split(/\s+/, 2)
           .join("/")
           .underscore
           .gsub(%r{[^\w\/]+}, "_")
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end
