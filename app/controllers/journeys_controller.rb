class JourneysController < ApplicationController
  before_action :set_car, only: [:new, :create, :show, :edit, :update, :destroy]

  def show
  end

  def index
    @journeys = Journey.all
  end

  def new
    @journey = Journey.new(car_id: @car.id)
  end

  def create
    @journey = @car.journeys.new(journey_params)

    if @journey.save
      @car.update(mileage: @car.mileage + @journey.mileage)
      redirect_to cars_path, notice: "Trip n°#{@journey.id} was successfully added to your car."
    else
      render :new
    end
  end
  
  private

  def journey_params
    params.require(:journey).permit(:car_id, :mileage, :date)
  end
  
  def set_car
    @car = Car.find(params[:car_id])
  end
end
