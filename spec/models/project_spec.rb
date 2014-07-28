require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  let(:parent) { FactoryGirl.create(:project, :identifier=> "foo") }
  let(:prefix) { "#{parent.identifier}#{Setting.plugin_openproject_ensure_project_hierarchy[:separator]}"}

  before :each do

    Project.stub!(:find_by_id).with(parent.id).and_return parent

    # Project.stub!(:find).and_return @project
    # @project.stub!(:safe_attributes=)
    # @project.stub!(:allowed_parents).and_return [parent]
    # @project.stub!(:set_allowed_parent!)
  end

  describe "when I try to validate a project with a parent project" do
    describe "and the submitted identifier hiearchy is correct" do

      it "then the creation should be successful" do
        project = FactoryGirl.create(:project, :identifier => "#{prefix}bar", :parent_id => parent.id)
        project.should be_valid
      end
    end
      
    describe "and the given identifier hierarchy is incorrect" do
      it "then an error should be set on the project" do
        lambda { FactoryGirl.create(:project, :identifier => "xyz", :parent_id => parent.id) }
        .should raise_error(ActiveRecord::RecordInvalid )
      end
    end
  end
end