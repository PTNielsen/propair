class AuthController < Devise::OmniauthCallbacksController

  def slack
    auth_data = request.env["omniauth.auth"]
    # token = auth_data.credentials.token
    # slack_id = auth_data.uid
    # slack_name = auth_data.info.nickname

    render :json => {auth_data:auth_data}
  end

end