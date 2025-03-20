$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "finitio/version"
$version = Finitio::Version.to_s

Gem::Specification.new do |s|
  s.name = "finitio"
  s.version = $version
  s.summary = "Finitio - in Ruby"
  s.description = "Implements the Finitio information language in Ruby."
  s.homepage = "https://github.com/blambeau/finitio"
  s.authors = ["Bernard Lambeau"]
  s.email  = ["blambeau@gmail.com"]
  s.require_paths = ["lib"]
  here = File.expand_path(File.dirname(__FILE__))
  s.files = File.readlines(File.join(here, 'Manifest.txt')).
                 inject([]){|files, pattern| files + Dir[File.join(here, pattern.strip)]}.
                 collect{|x| x[(1+here.size)..-1]}

  s.test_files = Dir["test/**/*"] + Dir["spec/**/*"]
  s.bindir = "bin"
  s.executables = (Dir["bin/*"]).collect{|f| File.basename(f)}

  s.add_dependency("citrus", ">= 3.0", "< 4.0")

  s.add_development_dependency("rake", "~> 13.0")
  s.add_development_dependency("rspec", "~> 3.0")
  s.add_development_dependency("cucumber", "~> 4.1")
  s.add_development_dependency('activesupport', '~> 7.0.8')
  s.add_development_dependency("path", ">= 2.1", "< 3.0")
  s.add_development_dependency("awesome_print", "~> 1.8")
  s.add_development_dependency("coveralls", "~> 0.8")
  s.add_development_dependency("multi_json", "~> 1.15")

  s.extensions = []
  s.requirements = nil
  s.post_install_message = nil
  s.rdoc_options = []
  s.extra_rdoc_files = Dir["README.md"] + Dir["CHANGELOG.md"] + Dir["LICENCE.md"]
end
