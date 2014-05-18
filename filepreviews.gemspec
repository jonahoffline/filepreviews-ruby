# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filepreviews/version'

Gem::Specification.new do |spec|
  spec.name          = 'filepreviews'
  spec.version       = Filepreviews::VERSION
  spec.authors       = ['Jonah Ruiz']
  spec.email         = ['jonah@pixelhipsters.com']
  spec.description   = %q(FilePreviews.io Ruby library and CLI application.)
  spec.summary       = %q(FilePreviews.io Ruby library and CLI for the service)
  spec.homepage      = 'https://github.com/jonahoffline/filepreviews-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'faraday', '~> 0.9.0'
  spec.add_dependency 'typhoeus', '~> 0.6.8'
end
