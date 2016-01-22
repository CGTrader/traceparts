# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'traceparts/version'

Gem::Specification.new do |spec|
  spec.name          = "traceparts"
  spec.version       = Traceparts::VERSION
  spec.authors       = ["Zilvinas"]
  spec.email         = ["zil.kucinskas@gmail.com"]

  spec.summary       = %q{A Ruby interface to the Traceparts API}
  spec.homepage      = "https://github.com/CGTrader/traceparts"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "faraday"
  spec.add_dependency "json"
end
