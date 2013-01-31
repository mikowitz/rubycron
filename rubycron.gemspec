# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubycron/version'

Gem::Specification.new do |gem|
  gem.name          = "rubycron"
  gem.version       = Rubycron::VERSION
  gem.authors       = ["Michael Berkowitz"]
  gem.email         = ["michael.berkowitz@gmail.com"]
  gem.description   = %q{Parser for cron expressions}
  gem.summary       = %q{Something about a river, and ... dammit, I swear I had something for this!}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency('cucumber')
  gem.add_development_dependency('guard')
  gem.add_development_dependency('guard-cucumber')
  gem.add_development_dependency('rb-fsevent')
  gem.add_development_dependency('growl')
end
