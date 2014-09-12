module OpenProject::EnsureProjectHierarchy
  module Patches
    module ProjectsControllerPatch

      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods

          alias_method_chain :new, :default_identifier_for_new_subprojects
          alias_method_chain :validate_parent_id, :identifier_hierarchy
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

        def validate_parent_id_with_identifier_hierarchy
          return true if User.current.admin?
          return false unless validate_parent_id_without_identifier_hierarchy

          parent_id = params[:project] && params[:project][:parent_id]
          seperator = Setting.plugin_openproject_ensure_project_hierarchy[:separator]
          if parent_id || @project.new_record?
            parent = parent_id.blank? ? nil : Project.find_by_id(parent_id.to_i)
            if parent && !@project.identifier.start_with?([parent.identifier, seperator].join)
              @project.errors.add :identifier, :prefix_invalid, :prefix => "#{parent.identifier}#{seperator}"
              return false
            end
          end
          true
        end

      end
    end
  end
end

ProjectsController.send(:include, OpenProject::EnsureProjectHierarchy::Patches::ProjectsControllerPatch)
