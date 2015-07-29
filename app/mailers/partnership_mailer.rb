class PartnershipMailer < ApplicationMailer
  default from: "admin@propair.com"

  def partnership_request project, current_user
    @project, @current_user = project, current_user
    mail(
      to: @project.author.email,
      subject: "#{@current_user.user_name} would like to pair on #{@project.title}!"
    )
  end

  def partnership_confirmed
    #Send Email to Requestor once confirmed by project author
  end
end