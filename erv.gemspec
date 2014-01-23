# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'erv/version'

Gem::Specification.new do |spec|
  spec.name          = 'erv'
  spec.version       = ERV::VERSION
  spec.authors       = ['Mauro Tortonesi']
  spec.email         = ['mauro.tortonesi@unife.it']
  spec.description   = "erv-#{ERV::VERSION}"
  spec.summary       = %q{Easy/elegant Ruby library providing support for random variable generation}
  spec.homepage      = 'https://github.com/mtortonesi/ruby-erv'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  if RUBY_PLATFORM =~ /java/
    # include Apache Commons Math 3.3 jar archive
    spec.files.concat(Dir['jars/*.jar'])
  else
    spec.add_dependency 'gsl-nmatrix'
  end
end
