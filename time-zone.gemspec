
require_relative "lib/time/zone/version"

Gem::Specification.new do |spec|
	spec.name          = "time-zone"
	spec.version       = Time::Zone::VERSION
	spec.authors       = ["Samuel Williams"]
	spec.email         = ["samuel.williams@oriontransfer.co.nz"]

	spec.summary       = "Use the system `date` command to compute time zones."
	spec.homepage      = "https://github.com/ioquatix/time-zone"

	spec.files         = `git ls-files -z`.split("\x0").reject do |f|
		f.match(%r{^(test|spec|features)/})
	end
	spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]

	spec.add_development_dependency "bundler", "~> 1.16"
	spec.add_development_dependency "rake", "~> 10.0"
	spec.add_development_dependency "rspec", "~> 3.0"
end
