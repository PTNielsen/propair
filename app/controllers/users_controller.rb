class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :invite]

  skip_authorization_check only: [:index, :show, :invite]
  
  before_action do
    request.format = :json
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    user = User.find params[:id]
    authorize! :update, user
  end

  def update
    user = User.find params[:id]
    authorize! :update, user

    user.update(edit_user_params)
    head :ok
  end

  def destroy
    user = User.find params[:id]
    authorize! :destroy, user

    user.destroy
    head :ok
  end

  def invite
    a = Invitation.new email: params[:email]
    # Could use InvitationMailer and '.deliver_later'
    a.perform
    head :ok
  end

private

  def edit_user_params
    params.require(:user).permit(:first_name, :last_name, :about_me, :city, :timezone, :skill_1, :skill_2, :skill_3, :skill_4, :skill_5, :github_link, :avatar)
  end

end