# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pingdom/version"

Gem::Specification.new do |spec|
  spec.name          = "pingdom"
  spec.version       = Pingdom::VERSION
  spec.authors       = ["Diego Piccinini Lagos"]
  spec.email         = ["diego@guiasrails.es"]

  spec.summary       = %q{Get data for the pingdom API}
  spec.description   = %q{Set up the username, password and key using dotenv. Get checks, results}
  spec.homepage      = "https://github.com/diegopiccinini/pingdom"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "dotenv", "~> 2.2"
  spec.add_dependency "httparty", "~> 0.15"
end
