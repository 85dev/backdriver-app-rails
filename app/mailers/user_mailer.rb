class UserMailer < ApplicationMailer
    default from: 'backdriver.contact@gmail.com'

    def welcome_email
        @user = params[:user]
        @url  = 'localhost:3000'
        mail(to: @user.email, subject: 'Welcome to Backdriver')
    end
end
