class AuthController < Devise::OmniauthCallbacksController
  def slack
    auth_data = request.env["omniauth.auth"]
    user = User.where(:email => auth_data.info.email).create_with(
      :user_name => auth_data.info.nickname,
      :admin     => auth_data.info.is_admin,
      :timezone  => auth_data["extra"]["user_info"]["user"]["tz_label"],
      :slack     => auth_data.to_h
      ).first_or_create!

    sign_in user

    token = user.auth_tokens.create!
    # render :json => {auth_data:auth_data}
    redirect_to "http://pro-pair.herokuapp.com#dashboard/#{token.key}"
  end
end