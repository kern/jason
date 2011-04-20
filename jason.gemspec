# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'jason/version'

Gem::Specification.new do |s|
  s.name        = 'jason'
  s.version     = Jason::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alexander Kern']
  s.email       = ['alex@kernul.com']
  s.homepage    = 'https://github.com/CapnKernul/jason'
  s.summary     = %q{Insanely simple JSON templates}
  s.description = %q{Create JSON templates using YAML and ERb}

  s.rubyforge_project = 'jason'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.add_development_dependency 'minitest', '~> 2.0'
  s.add_development_dependency 'mocha', '~> 0.9'
  s.add_development_dependency 'autotest', '~> 4.4'
  s.add_development_dependency 'rails', '3.0.5'
  s.add_development_dependency 'json', '~> 1.5'
  s.add_development_dependency 'yard', '~> 0.6'
  s.add_development_dependency 'maruku', '~> 0.6'
end