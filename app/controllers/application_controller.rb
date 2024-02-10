class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_common_variables

    def set_common_variables
        @user_notification = current_user ? calculate_notifications(current_user) : 0
    end

    private

    def calculate_notifications(user)
        return 0 unless user.cars

        notifications_count = 0
    
        user.cars.each do |car|
          notifications_count += 1 if car.technical_control.valid_until < Date.current
          notifications_count += 1 if car.insurance.assured_until < Date.current 
          notifications_count += 1 if car.maintainance.last_repair_date < (Date.current.year - 3)
        end
        return notifications_count
    end

    def configure_permitted_parameters
        # For additional fields in app/views/devise/registrations/new.html.erb
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

        # For additional in app/views/devise/registrations/edit.html.erb
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar, :last_name, :first_name])
    end
end
