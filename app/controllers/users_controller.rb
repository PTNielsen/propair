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
  end

  def update
    user = User.find params[:id]

    user.update(edit_user_params)
    head :ok
  end

  def destroy
    user = User.find params[:id]

    user.destroy
    head :ok
  end

  def invite
    a = Invitation.new email: params[:email]
    # InvitationMailer.invite(bought_item, current_user).deliver_later
    a.perform
    head :ok
  end

private

  def edit_user_params
    params.require(:user).permit(:email, :password, :user_name, :first_name, :last_name, :about_me, :city, :skill_1, :skill_2, :skill_3, :skill_4, :skill_5, :github_link, :avatar)
  end

end