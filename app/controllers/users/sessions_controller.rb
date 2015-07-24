class Users::SessionsController < Devise::SessionsController
before_filter :configure_sign_in_params, only: [:create]

  GET /resource/sign_in
  def new
    super
  end

  POST /resource/sign_in
  def create
    super
    # binding.pry
    # auth_data = request.env["omniauth.auth"]
    # User.where({
    #   :email => auth_data.info.email
    #   :user_name => auth_data.info.nickname
    #   :slack => auth_data
    #   }).first_or_create
  end

  DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :email, :user_name, :slack
  end
end