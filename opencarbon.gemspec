# -*- encoding: utf-8 -*-
require File.expand_path('../lib/opencarbon/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bo Daley"]
  gem.email         = ["bo@factorypreset.com"]
  gem.description   = %q{Ruby interface to OpenCarbon data files}
  gem.summary       = %q{Methods for accessing data attributes in OpenCarbon disclosure documents}
  gem.homepage      = "http://opencarbon.org/ruby"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "opencarbon"
  gem.require_paths = ["lib"]
  gem.version       = OpenCarbon::VERSION

  gem.add_dependency 'debugger'
  gem.add_dependency 'rspec'
  gem.add_dependency 'json'

end
