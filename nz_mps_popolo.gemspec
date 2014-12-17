# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nz_mps_popolo/version'

Gem::Specification.new do |spec|
  spec.name          = 'nz_mps_popolo'
  spec.version       = NZMPsPopolo::VERSION
  spec.authors       = ['Caleb Tutty']
  spec.email         = ['caleb.tutty@nzherald.co.nz']
  spec.summary       = %q{Scrapes and formats New Zealand MPs into a Popolo compliant format}
  spec.description   = %q{This gem scrapes the details of New Zealand Members of Parliament from the Parliamentary website and formats records according to the Popolo spec (popoloproject.com).}
  spec.homepage      = 'https://github.com/nzherald/nz-mps-popolo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'capybara', '~> 2.4.4'
  spec.add_runtime_dependency 'capybara-mechanize', '~> 1.4.0'
  spec.add_runtime_dependency 'feedjira', '~> 1.5.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
