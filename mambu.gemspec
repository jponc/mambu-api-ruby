# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mambu/version'

Gem::Specification.new do |spec|
  spec.name          = "mambu"
  spec.version       = Mambu::VERSION
  spec.authors       = ["Netguru"]
  spec.email         = ["netguru@netguru.co"]

  spec.summary       = "mambu.com REST API wrapper"
  spec.description   = "mambu.com REST API wrapper"
  spec.homepage      = "http://github.com/netguru/mambu-api-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry"

  spec.add_dependency "activesupport"
  spec.add_dependency "faraday"
end
