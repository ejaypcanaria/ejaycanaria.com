$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "admin"
  s.version     = Admin::VERSION
  s.authors     = ["Ejay Canaria"]
  s.email       = ["ejaypcanaria@gmail.com"]
  s.homepage    = "/admin"
  s.summary     = "This is the administrator panel of ejaypcanaria.com"
  s.description = "This is the administrator panel of ejaypcanaria.com"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end
