# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jactive_support/version"

Gem::Specification.new do |s|
  s.name        = "jactive_support"
  s.platform    = Gem::Platform::CURRENT
  s.version     = JActiveSupport::VERSION
  s.author      = "Brian Olsen"
  s.email       = "brian@maven-group.org"
  s.homepage    = "http://github.com/griff/jactive_support"
  s.summary     = "Extensions to add some activesupport flavor to java classes"
  s.description = %q{Extensions to add some activesupport flavor to java classes}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport', "~> 2.3.8"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "rake", ">= 0.9.2"
end
