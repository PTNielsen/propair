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

  def test_user_can_post_project
    create_project

    project = Project.last

    assert_equal 1, Project.count
    assert_equal 200, response.status
    assert_includes "Test Project", project.title
  end

  def test_user_can_edit_project
    create_project

    before_edit = Project.last

    assert_equal 1, Project.count
    assert_equal 200, response.status
    assert_includes "Test Project", before_edit.title

    patch :update, id: before_edit.id, project: { title: "Updated" }

    after_edit = Project.last

    assert_equal 1, Project.count
    assert_equal 200, response.status
    assert_includes "Updated", after_edit.title
  end

  def test_user_can_delete_project
    create_project

    project = Project.last

    assert_equal 1, Project.count
    assert_equal 200, response.status
    assert_includes "Test Project", project.title

    delete :destroy, id: project.id

    assert_equal 0, Project.count
    assert_equal 200, response.status
  end

  def test_admin_can_edit_other_projects
    create_project

    before_edit = Project.last

    assert_equal 1, Project.count
    assert_equal 200, response.status
    assert_includes "Test Project", before_edit.title

    sign_out_and_clear_cached_currents!

    a = create(:user, admin: true)
    sign_in a

    patch :update, id: before_edit.id, project: { title: "Updated" }

    after_edit = Project.last

    assert_equal 1, Project.count
    assert_equal 200, response.status
    assert_includes "Updated", after_edit.title
  end

  def test_admin_can_delete_other_projects
    create_project

    project = Project.last

    assert_equal 1, Project.count
    assert_equal 200, response.status
    assert_includes "Test Project", project.title

    sign_out_and_clear_cached_currents!

    a = create(:user, admin: true)
    sign_in a

    delete :destroy, id: project.id

    assert_equal 0, Project.count
    assert_equal 200, response.status
  end

  def test_user_can_not_edit_other_projects
    create_project

    before_edit = Project.last

    assert_equal 1, Project.count
    assert_equal 200, response.status
    assert_includes "Test Project", before_edit.title

    sign_out_and_clear_cached_currents!

    a = create(:user)
    sign_in a

    request.env["HTTP_REFERER"] = "/"

    patch :update, id: before_edit.id, project: { title: "Updated" }

    after_edit = Project.last

    assert_equal 1, Project.count
    assert_equal 302, response.status
    assert_includes "Test Project", after_edit.title
    assert_equal "/", response.redirect_url
  end

  def test_user_can_not_delete_other_projects
    create_project

    project = Project.last

    assert_equal 1, Project.count
    assert_equal 200, response.status
    assert_includes "Test Project", project.title

    sign_out_and_clear_cached_currents!

    a = create(:user)
    sign_in a

    request.env["HTTP_REFERER"] = "/"

    delete :destroy, id: project.id
    binding.pry
    assert_equal 1, Project.count
    assert_equal 302, response.status
    assert_equal "/", response.redirect_url
  end

end