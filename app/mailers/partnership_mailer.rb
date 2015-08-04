class PartnershipMailer < ApplicationMailer
  default from: "admin@propair.com"

  def partnership_request project, current_user
    @project, @current_user = project, current_user
    mail(
      to: @project.author.email,
      subject: "ProPair Notification - #{@current_user.user_name} would like to pair on #{@project.title}!"
    )
  end

  def partnership_confirmation project, request
    @project, @request = project, request
    mail(
      to: @request.requestor.email,
      subject: "ProPair Notification - #{@project.title} pair request accepted!"
    )
  end
end