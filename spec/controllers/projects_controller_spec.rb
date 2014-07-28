require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do

  before do
    @project = FactoryGirl.create(:project)
    @parent = FactoryGirl.create(:project, :identifier=> "foo")

    Project.stub(:find).with(@parent.identifier).and_return @parent
    Project.stub!(:new).and_return(@project)

    @controller.stub!(:authorize)
    @controller.stub!(:check_if_login_required)
  end


  describe "when I navigate to the new project page after having clicked the 'New subproject' link" do
    describe "the identifier of the new project" do

      it "should default to the parent's identifier with the project identifier separator" do
        @project.should_receive(:identifier=).with "#{@parent.identifier}#{Setting.plugin_openproject_ensure_project_hierarchy[:separator]}"
        get :new, :parent_id => @parent.identifier
      end
    end
  end
end