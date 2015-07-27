class AuthController < Devise::OmniauthCallbacksController

  def slack
    auth_data = request.env["omniauth.auth"]
    User.where(:email => auth_data.info.email).create_with(
      :user_name => auth_data.info.nickname,
      :admin => auth_data.info.is_admin,
      :slack => auth_data.to_h
      ).first_or_create!

    render :json => {auth_data:auth_data}
  end

end