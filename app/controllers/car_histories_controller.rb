class CarHistoriesController < ApplicationController
  def permitted_paramaters 
    params.require(:car_history).permit(:user_id, :total_sold_cars_value, :cars_sold)
  end
end
