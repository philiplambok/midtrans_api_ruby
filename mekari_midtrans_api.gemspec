# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'midtrans_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'mekari_midtrans_api'
  spec.version       = MidtransApi::Version::VERSION
  spec.authors       = ['Fadli Zul Fahmi']
  spec.email         = ['mekari@fadli.dev']

  spec.summary       = 'Mekari Midtrans API Wrapper'
  spec.description   = "Let's make installment credit card using Midtrans!"
  spec.homepage      = 'https://github.com/mekari-engineering/midtrans_api_ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '>=0.9'
  spec.add_dependency 'faraday_middleware', '>=0.9'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end