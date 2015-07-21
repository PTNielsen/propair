# class Users::SessionsController < Devise::SessionsController
class UsersController < ApplicationController  
  skip_before_action :authenticate_user!, only: [:index, :show]

  skip_authorization_check only: [:index, :show]
  
  before_action do
    request.format = :json
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def new
  end

  def create
  end

  def destroy
  end

end