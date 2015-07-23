class RegistrationsController < Devise::RegistrationsController

  def create
    user = User.create!(create_user_params)
    #send slack invite email
    redirect_to user
  end

private

  def create_user_params
    params.permit(:email, :password, :user_name, :first_name, :last_name)
  end

end