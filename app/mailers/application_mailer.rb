class ApplicationMailer < ActionMailer::Base
  default from: "info@backdriver.com"
  layout "mailer"

  def mailer(email)
    mail to: email, subject: 'Thanks for joining Backdriver, confirm your email with the link below.'
  end
end
