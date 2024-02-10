class NotificationsController < ApplicationController

    private 

    def permitted_parameters 
        params.require(:notification).permit(:user_id, :read, :message)
    end
end
