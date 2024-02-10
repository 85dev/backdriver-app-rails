class UserMailer < ApplicationMailer
    default from: 'backdriver.contact@gmail.com'

    def technical_inspection_email(car)
        puts car
        @car = car
        @user = User.find_by(id: car.user_id)
        mail(to: @user.email, subject: 'Technical Inspection Reminder')
    end
end
