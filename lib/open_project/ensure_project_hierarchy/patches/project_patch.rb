module OpenProject::EnsureProjectHierarchy
  module Patches
    module ProjectPatch

      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods

          validate :identifier_hierarchy_correctness
        end
      end


      module InstanceMethods

        private

        def identifier_hierarchy_correctness
          return true if User.current.admin?

          if parent && !identifier.start_with?([parent.identifier,
            Setting.plugin_openproject_ensure_project_hierarchy[:separator]].join)

            errors.add :identifier, :prefix_invalid, :prefix => "#{parent.identifier}-"
            return false
          end
          true
        end
      end
    end
  end
end

Project.send(:include, OpenProject::EnsureProjectHierarchy::Patches::ProjectPatch)
