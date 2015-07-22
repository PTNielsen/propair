class UsersController < ApplicationController
  
  before_action do
    request.format = :json
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    @user.update(edit_user_params)
  end

  def destroy
    @user = User.find params[:id]

    @user.delete
  end

private

  def edit_user_params
    params.require(:user).permit(:email, :password, :user_name, :first_name, :last_name, :about_me, :city, :skill_1, :skill_2, :skill_3, :skill_4, :skill_5, :github_link, :avatar)
  end

end