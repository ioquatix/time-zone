
require_relative "lib/time/zone/version"

Gem::Specification.new do |spec|
	spec.name = "time-zone"
	spec.version = Time::Zone::VERSION
	spec.authors = ["Samuel Williams"]
	spec.email = ["samuel.williams@oriontransfer.co.nz"]
	
	spec.summary = "Computes timezones using the system TZ environment variable."
	spec.homepage = "https://github.com/ioquatix/time-zone"
	
	spec.files = Dir['{lib}/**/*', base: __dir__]
	spec.require_paths = ["lib"]
	
	spec.add_development_dependency "bundler"
	spec.add_development_dependency "rspec"
	spec.add_development_dependency "bake-bundler"
end
