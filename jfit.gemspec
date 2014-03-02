# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jfit/version'

Gem::Specification.new do |spec|
  spec.name          = "jfit"
  spec.version       = Jfit::VERSION
  spec.authors       = ["Gareth Townsend"]
  spec.email         = ["gareth.townsend@me.com"]
  spec.summary       = %q{A JRuby library for parsing FIT files.}
  spec.description   = %q{A JRuby library for parsing FIT files. Uses the http://thisisant.com FIT SDK.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
