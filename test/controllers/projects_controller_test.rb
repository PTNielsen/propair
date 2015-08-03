require 'test_helper'
require 'pry'

class ProjectsControllerTest < ActionController::TestCase

    def create_project
      @u = create(:user)
      sign_in @u

      project :create, 
    end

    def test_user_can_post_project
    end

    def test_user_can_edit_project
    end

    def test_user_can_delete_project
    end

    def test_admin_can_edit_other_projects
    end

    def test_admin_can_delete_other_projects
    end

    def test_user_can_not_edit_other_projects
    end

    def test_user_can_not_delete_other_projects
    end

end