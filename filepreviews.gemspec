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
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['github_repo'] = spec.homepage

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.4'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'faraday', '~> 0.15.0'
  spec.add_dependency 'typhoeus', '~> 1.3.0'
end
