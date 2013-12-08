# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'genetic/version'

Gem::Specification.new do |spec|
  spec.name          = "genetic"
  spec.version       = Genetic::VERSION
  spec.authors       = ["Nigel Lowry"]
  spec.email         = ["nigel-lowry@ultra.eclipse.co.uk"]
  spec.description   = %q{Genetic algorithm gem}
  spec.summary       = %q{Gem that uses a genetic algorithm. If someone wants to make this more general-purpose, please do}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["genetic"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'random_outcome'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
