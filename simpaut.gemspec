# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simpaut/version'

Gem::Specification.new do |spec|
  spec.name          = "simpaut"
  spec.version       = Simpaut::VERSION
  spec.authors       = ["Marek Hulan"]
  spec.email         = ["mhulan@redhat.com"]

  spec.summary       = %q{Personal automation project}
  spec.description   = %q{Simple API for home device automation, tailored to specific needs}
  spec.homepage      = "https://github.com/ares/simpaut"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'pry'

  spec.add_dependency 'sinatra'
  spec.add_dependency 'samsung_wam_api'
end
