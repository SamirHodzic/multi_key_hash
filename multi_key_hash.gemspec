
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "multi_key_hash/version"

Gem::Specification.new do |spec|
  spec.name          = 'multi_key_hash'
  spec.version       = MultiKeyHash::VERSION
  spec.authors       = ['SamirHodzic']
  spec.email         = ['samir.sgd@gmail.com']

  spec.summary       = 'something'
  spec.description   = 'somethingaa'
  spec.homepage      = 'http://something.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

	spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'bundler', '~> 1.3'
	spec.add_development_dependency 'rspec', '~> 3.0'
end
