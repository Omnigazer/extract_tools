$:.push File.expand_path("../lib", __FILE__)

require "extract_tools"
# Maintain your gem's version:
require "extract_tools/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "extract_tools"
  s.version     = ExtractTools::VERSION
  s.authors     = ["Omnigazer"]
  s.email       = ["omnigazer@gmail.com"]
  s.homepage    = "https://github.com/Omnigazer/extract_tools"
  s.summary     = "A sample tool for extracting image links from a given page."
  s.description = "A sample tool for extracting image links from a given page."
  s.license     = "MIT"

  s.require_paths = ["lib"]

  s.add_runtime_dependency 'httparty'
  s.add_runtime_dependency 'nokogiri'

  s.add_development_dependency 'pry'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec/core'
  s.add_development_dependency 'rspec-mocks'
  s.add_development_dependency 'webmock'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
end
