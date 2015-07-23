class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :authenticate_user!

  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do
    redirect_to :back, notice: "You are not authorized to see this page"
  end

  # rescue_from GH::NotAuthorized do |e|  ** If we have time **
  #   session[:_after_slack_auth_redirect_path] = request.path
  #   redirect_to user_omniauth_authorize_path(:slack)
  # end

  def home
    render json: current_user
  end
end