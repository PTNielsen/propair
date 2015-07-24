class ApplicationMailer < ActionMailer::Base
  default from: "admin@propair.com"

  layout 'mailer'
end