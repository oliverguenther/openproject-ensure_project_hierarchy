module OpenProject::EnsureProjectHierarchy
  module Patches
    module ProjectsControllerPatch

      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods

          alias_method_chain :new, :default_identifier_for_new_subprojects
        end
      end


      module InstanceMethods

        private
        
        def new_with_default_identifier_for_new_subprojects
          new_without_default_identifier_for_new_subprojects
          if params[:parent_id]

            parent_project = Project.find params[:parent_id]
            @project.identifier = [parent_project.identifier,
              Setting.plugin_openproject_ensure_project_hierarchy[:separator]].join

            Rails.logger.info("[EnsureProjectHierarchy] Overriding project identifier to #{@project.identifier}")
          end
        end
      end
    end
  end
end

ProjectsController.send(:include, OpenProject::EnsureProjectHierarchy::Patches::ProjectsControllerPatch)
