class AuthController < Devise::OmniauthCallbacksController

  def slack
    auth_data = request.env["omniauth.auth"]
    token = auth_data.credentials.token
    render :json => {token:token}
  end


end