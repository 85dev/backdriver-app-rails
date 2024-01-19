class CarOptionsController < ApplicationController
    before_action :set_car_option, only: [:show, :edit, :update, :destroy]

    def index
      @car_options = CarOption.all
    end
  
    def show
    end
  
    def new
      @car_option = CarOption.new
    end
  
    def create
      @car_option = CarOption.new(car_option_params)
  
      if @car_option.save
        redirect_to @car_option, notice: 'Car option was successfully created.', class: 'scale-in-ver-center'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @car_option.update(car_option_params)
        redirect_to @car_option, notice: 'Car option was successfully updated.', class: 'scale-in-ver-center'
      else
        render :edit
      end
    end
  
    def destroy
      @car_option.destroy
      redirect_to car_options_url, notice: 'Car option was successfully destroyed.'
    end

    private

    def set_car_option
        @car_option = CarOption.find(params[:id])
    end

    def car_option_params 
        params.require(:car_option).permit(
        :exterior_color, :interior_color, :motricity, :gearbox, :vehicle_type,
        :model, :door_number, :modifications, :modified, :original, :specifications,
        :leather_interior, :specific_material)
    end
end
