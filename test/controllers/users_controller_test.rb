require 'test_helper'
require 'pry'

class UsersControllerTest < ActionController::TestCase

  def sign_in_user
    @u = create(:user)
    sign_in @u
  end

  def sign_out_and_clear_cached_currents!
    sign_out @u
    # This is how cancan wants us to reset the `current_ability`, used by `authorize!`
    @controller.instance_variable_set :@current_user, nil
    @controller.instance_variable_set :@current_ability, nil
  end

  def test_user_can_edit_own_profile
    sign_in_user

    before_edit_user = User.first

    assert_equal 1, User.count
    assert_equal nil, before_edit_user.city

    patch :update, id: before_edit_user.id, user: { city: "Washington, DC"}

    after_edit_user = User.first

    assert_equal 1, User.count
    assert_equal "Washington, DC", after_edit_user.city
    assert_equal 200, response.status
  end

  def test_admin_can_edit_other_profile
    sign_in_user

    before_edit_user = User.first

    assert_equal 1, User.count
    assert_equal nil, before_edit_user.city

    sign_out_and_clear_cached_currents!

    a = create(:user, admin: true)
    sign_in a

    patch :update, id: before_edit_user.id, user: { city: "Washington, DC"}

    after_edit_user = User.first

    assert_equal "Washington, DC", after_edit_user.city
    assert_equal 200, response.status
  end

  def test_admin_can_delete_other_profile
    sign_in_user

    user = User.first

    assert_equal 1, User.count
    assert_equal false, user.admin

    sign_out_and_clear_cached_currents!

    a = create(:user, admin: true)
    sign_in a

    assert_equal 2, User.count

    delete :destroy, id: user.id

    assert_equal 1, User.count
    assert_equal true, User.first.admin
    assert_equal 200, response.status
  end

  def test_user_can_not_edit_other_profile
    sign_in_user

    before_edit_user = User.first

    assert_equal 1, User.count
    assert_equal nil, before_edit_user.city

    sign_out_and_clear_cached_currents!

    a = create(:user)
    sign_in a

    request.env["HTTP_REFERER"] = "/"

    patch :update, id: before_edit_user.id, user: { city: "Washington, DC"}
  
    after_edit_user = User.first

    assert_equal nil, after_edit_user.city
    assert_equal 302, response.status  
    assert_equal "/", response.redirect_url
  end

  def test_user_can_not_delete_other_profile
    sign_in_user

    user = User.first

    assert_equal 1, User.count

    sign_out_and_clear_cached_currents!

    a = create(:user)
    sign_in a

    request.env["HTTP_REFERER"] = "/"
       
    delete :destroy, id: user.id

    assert_equal 2, User.count
    assert_equal 302, response.status
    assert_equal "/", response.redirect_url
  end

end