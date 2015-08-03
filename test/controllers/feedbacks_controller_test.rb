require 'test_helper'
require 'pry'

class ProjectsControllerTest < ActionController::TestCase

  def create_project
    @u = create(:user)
    sign_in @u

    post :create, project: { author_id: @u.id, title: "Test Project", description: "This is a project to test our controller"}
  end

  def sign_out_and_clear_cached_currents!
    sign_out @u
    # This is how cancan wants us to reset the `current_ability`, used by `authorize!`
    @controller.instance_variable_set :@current_user, nil
    @controller.instance_variable_set :@current_ability, nil
  end

  def user_can_create_feedback
  end

  def user_can_edit_feedback
  end

  def user_can_delete_feedback
  end

  def test_admin_can_edit_other_feedback
  end

  def test_admin_can_delete_other_feedback
  end

end