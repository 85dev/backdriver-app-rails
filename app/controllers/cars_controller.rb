require 'date'
require 'cloudinary'

class CarsController < ApplicationController
  before_action :set_car, only: [:update, :destroy, :edit, :show]
  before_action :set_cars, only: [:index, :statistics, :urgent_informations, :repairs, :actions]

  def new
    @car = Car.new
    @car.build_car_option
    @car.build_insurance
    @car.build_maintainance
    @car.build_technical_control
  end

  def create
    @car = Car.new(car_params)
    @car.user_id = current_user.id

    ActiveRecord::Base.transaction do
      if @car.save
        redirect_to cars_path, notice: 'Car has been created.', class: 'scale-in-ver-center'
      else
        render :new, notice: "Error. Car could not be created."
      end
    end
  end

  def update
    if @car.update(car_params)
      redirect_to cars_path, notice: "Car's informations were successfully updated."
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    selling_price = params[:car][:selling_price]

    car_history = current_user.car_history
  
    if car_history.nil?
      CarHistory.create(
        user: current_user,
        total_sold_cars_value: selling_price,
        cars_sold: 1
      )
    else
      car_history.update(
        total_sold_cars_value: (car_history.total_sold_cars_value || 0) + selling_price.to_i,
        cars_sold: (car_history.cars_sold || 0) + 1
      )
    end
  
    @car.destroy
    redirect_to cars_url, notice: 'Car was successfully deleted, find the history of your cars in the dedicated window'
  end
  
  def index
    @car_history = current_user.car_history
  end

  def repairs 
  end

  def urgent_informations
    @unmaintained_cars = fetch_unmaintained_cars(@cars)
    @invalid_cars = fetch_invalid_cars(@cars)
  end

  def show
    @insurance = @car.insurance 
    @maintainance = @car.maintainance
    @technical_control = @car.technical_control
    @repairs = @car.repairs if @car.repairs
    @valid_technical_control = @car.technical_control.valid_until > Date.today
    @valid_insurance = @car.insurance.assured_until > Date.today
    # HEALTH SCORE FUNCTION
  end

  def statistics
    @yearly_date = Date.today.year
    @total_cars_worth = calculate_total_cars_worth(@cars)
    @cars_number = @cars.count
    @total_cars_worth_string = separate_number_with_dots(@total_cars_worth)
    @average_car_mileage = average_car_mileage(@cars)
    @average_car_age = average_car_age(@cars)
    @total_insurance_costs = calculate_total_insurance_cost(@cars)
  end

  def actions 
    # setup warnings for technical control
    # setup insurance reminder 
    # setup maintainance control with a periodicity
  end

  private

  def fetch_invalid_cars(cars)
    if cars
      invalid_cars = []

      cars.each do |car|
        if car.technical_control.valid_until <= Date.today
          invalid_cars << car
        end
      end

      return invalid_cars
    end
  end

  def fetch_unmaintained_cars(cars)
    if cars
      unmaintained_cars_array = []
  
      cars.each do |car|
        if car.maintainance.last_repair_date.year <= Date.today.year - 3
          unmaintained_cars_array << car
        end
      end

      return unmaintained_cars_array
    end
  end

  def calculate_total_insurance_cost(cars)
    if cars
      total_costs = 0

      cars.each do |car|
        total_costs += car.insurance.assurance_price
      end

      return separate_number_with_dots(total_costs)
    end
  end

  def average_car_mileage(cars)
    if cars 
      total_mileage = 0
      cars_number = 0
      average_car_milage = 0

      total_mileage = cars.sum(&:mileage)

      average_car_milage = total_mileage / cars_number.count if (total_mileage > 0 && cars_number > 0)

      return separate_number_with_dots(average_car_milage)
    end
  end

  def average_car_age(cars)
    if cars
      total_cars_age = 0
      current_year = Date.today.year
      
      cars.each do |car|
        if car.release_date.present?
          total_cars_age += current_year - car.release_date.year.to_f
        else
          return total_cars_age = "No data"
        end

      end
    
      counter = cars.count
      average_age = (counter > 0) ? (total_cars_age / counter) : 0
    
      average_age.nan? ? 0 : average_age
    end
  end
  

  def set_car 
    @car = Car.find(params[:id])
  end 

  def calculate_total_cars_worth(cars)
    if cars 
      total_cars_worth = 0
      cars.each do |car|
        total_cars_worth += car.purchase_price.to_i
      end
      return total_cars_worth
    end
  end

  def set_cars
    @cars = Car.all
  end

  def separate_number_with_dots(number)
    total_value_string = ""

    return total_value_string = number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1 ').reverse
  end

  def car_params
    params.require(:car).permit(
      :model_specific_name, :model_year,:release_date, :brand, :fuel, :motricity, 
      :gearbox, :vehicle_type, :model, :door_number, :fiscal_power,
      :required_licence, :horse_power, :seats, :acquisition_date, 
      :owners_number, :tire_size_front, :tire_size_back, :mileage, 
      :purchase_price, :estimated_value, :geolocalisation, :drivable, :accidented, :to_sell, :last_time_driven, 
      :numberplate, :required_licence, :interior_state, :exterior_state, :acquisition_date, :photo, 
      :drive_count_since_acquisition, :journey_taken, :regularly_maintained, :tires_state, :selling_price,

      car_option_attributes: [
        :exterior_color, :interior_color, :motricity, :gearbox, :vehicle_type,
        :model, :door_number, :modifications, :interior_material, :exterior_material, :original, :specifications
      ],

      insurance_attributes: [
        :assurance_type, :assured_until, :assurance_price,
        :assurance_company
      ],

      maintainance_attributes: [
        :maintainance_costs, :maintainance_needed, :drivable, :accidented,
        :repair_company, :last_repair_date
      ],

      technical_control_attributes: [
        :technical_control_frequency, :technical_control_price, :control_company,
        :counter_visit_at_last_control, :issues_encountered, :valid_until
      ])
  end

  def insurance_params
    params.require(:car).require(:insurance_attributes).permit(
      :assurance_type, :assured_until, :assurance_price, :assurance_company
    )
  end

  def maintainance_params
    params.require(:car).require(:maintainance_attributes).permit(
      :maintainance_costs, :maintainance_needed, :drivable, :accidented,
      :major_issues, :maintainance_periodicity, :repair_company, :last_repair_date
    )
  end

  def technical_control_params
    params.require(:car).require(:technical_control_attributes).permit(
      :technical_control_frequency, :technical_control_price, :control_company,
      :counter_visit_at_last_control, :issues_encountered, :valid_until
    )
  end

  def car_option_params
    params.require(:car).require(:car_option_attributes).permit(
      :exterior_color, :interior_color, :motricity, :gearbox, :vehicle_type,
      :model, :door_number, :modifications, :modified, :original, :specifications,
      :leather_interior, specific_material: []
    )
  end
end
