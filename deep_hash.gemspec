# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "deep_hash/version"

Gem::Specification.new do |s|
  s.name        = "deep_hash"
  s.version     = DeepHash::VERSION
  s.authors     = ["Caleb Spare"]
  s.email       = ["cespare@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Utilities for dealing with multi-level hashes}
  s.description = %q{DeepHash is a collection of utilities for dealing with multi-level hashes.}

  s.rubyforge_project = "deep_hash"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "scope", "~> 0.2.2"
end
