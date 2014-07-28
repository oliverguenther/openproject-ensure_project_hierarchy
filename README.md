# OpenProject Ensure Project Hierarchy Plugin

This plugin ensures subproject identifiers are prefixed with their parent
project's identifier.

## Notes

* Admins are allowed to set any identifier regardless of the parent project.
* You cannot update the identifier of a project without changing the parent project to a matching value.

## Requirements

* OpenProject Version >= 3.0


## Installation

Create a file `Gemfile.plugins` in your OpenProject installation with the following content:

	gem "openproject-plugins", :git => "https://github.com/opf/openproject-plugins.git", :branch => "stable" 
	gem "openproject-ensure_project_hierarchy", :git => "https://github.com/oliverguenther/openproject-ensure_project_hierarchy.git", :branch => "stable"


Please see the [OpenProject plugin overview](https://www.openproject.org/projects/openproject/wiki/OpenProject_Plug-Ins)
for more details.

## License

Copyright (c) 2014 Oliver Günther (mail@oliverguenther.de)

This plugin is forked from the [ChiliProject Ensure Project Hierarchy Plugin](https://github.com/thegcat/chiliproject_ensure_project_hierarchy) by Felix Schäfer.

Copyright (c) 2011 Felix Schäfer

This plugin is licensed under the MIT license. See COPYING for details.
