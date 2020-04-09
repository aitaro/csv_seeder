require_relative 'lib/csv_seeder/version'

Gem::Specification.new do |spec|
  spec.name          = "csv_seeder"
  spec.version       = CsvSeeder::VERSION
  spec.authors       = ["Aitaro Chaya"]
  spec.email         = ["aitaro.chaya@gmail.com"]

  spec.summary       = %q{Import rails seed from csv.}
  spec.description   = %q{I will write about how to use here.}
  spec.homepage      = "https://github.com/aitaro/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aitaro/csv_seeder"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
