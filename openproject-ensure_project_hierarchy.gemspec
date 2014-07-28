# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'open_project/ensure_project_hierarchy/version'
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "openproject-ensure_project_hierarchy"
  s.version     = OpenProject::EnsureProjectHierarchy::VERSION
  s.authors     = ["Oliver Günther", "Felix Schäfer"]
  s.email       = "mail@oliverguenther.de"
  s.homepage    = "https://www.github.com/oliverguenther/openproject-ensure_project_hierarchy"
  s.summary     = 'Ensure Project Hierarchy Plugin'
  s.description = "This plugin ensures subproject identifiers are prefixes with their parent project's identifier."
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*"] + %w(README.md)

  s.add_dependency "rails", "~> 3.2"

end
