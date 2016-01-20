# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jill/version'

Gem::Specification.new do |spec|
  spec.name          = "jill"
  spec.version       = Jill::VERSION
  spec.authors       = ["Dotan Nahum"]
  spec.email         = ["jondotan@gmail.com"]

  spec.summary       = %q{Jill is your README.md assistant}
  spec.description   = %q{Jill is your README.md assistant}
  spec.homepage      = "https://github.com/jondot/jill"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'slop', '~> 4.2.1'
  spec.add_dependency 'colorize', '~> 0.7.7'
  spec.add_dependency 'kramdown', '~> 1.9.0'
  spec.add_dependency 'nokogiri', '~> 1.6.7'
  spec.add_dependency 'parallel', '~> 1.6.1'
  spec.add_dependency 'httparty', '~> 0.13.7'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
