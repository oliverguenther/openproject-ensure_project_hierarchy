module OpenProject::EnsureProjectHierarchy
  class Engine < ::Rails::Engine
    engine_name :openproject_ensure_project_hierarchy


    def self.settings
      { :partial => 'settings/openproject_ensure_project_hierarchy',
        :default => {
          :separator => '-',
        }
      }
    end

    include OpenProject::Plugins::ActsAsOpEngine

    register 'openproject-ensure_project_hierarchy',
      :author_url => 'https://github.com/oliverguenther/openproject-ensure_project_hierarchy',
      :requires_openproject => '>= 3.0.0',
      :settings => settings

    patches [ :Project, :ProjectsController ]

  end
end
