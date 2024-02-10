require 'date'
require 'cloudinary'

class CarsController < ApplicationController
  before_action :set_user
  before_action :set_car, only: [:update, :destroy, :edit, :delete, :show]
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
    @car.user_id = @user.id

    ActiveRecord::Base.transaction do
      if @car.save
        redirect_to cars_path, notice: 'Car has been created.', class: 'scale-in-ver-center'
      else
        render :new, notice: "Error. Car could not be created."
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      if @car.update(car_params)
        redirect_to cars_path, notice: "Car's informations were successfully updated."
      else
        render :edit
      end
    end
  end
  
  def edit
    @car.car_option
    @car.insurance
    @car.maintainance
    @car.technical_control 
  end

  def destroy    
    selling_price = params[:car][:selling_price]

    car_history = @user.car_history
  
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

    @user.car.destroy
    redirect_to cars_url, notice: 'Car was successfully deleted, find the history of your cars in the dedicated window'
  end

  def add_trip 
    @user.car = Car.find(params[:format])
  end

  def before_destroy
    @user.car = Car.find(params[:format]) 
  end
  
  def index
    if params[:query].present? && @user.cars.present?
      @cars = search_by_model(params[:query])
      @reset_button = true
    else
      @cars = Car.where(user_id: @user.id)
      @reset_button = false
    end
  end

  def urgent_informations
    @unmaintained_cars = fetch_unmaintained_cars(@user.cars)
    @invalid_cars = fetch_invalid_cars(@user.cars)
    @uninsured_cars = fetch_uninsured_cars(@user.cars)
  end

  def show
    @insurance = @car.insurance 
    @maintainance = @car.maintainance
    @technical_control = @car.technical_control
    @repairs = @car.repairs if @car.repairs
    @valid_technical_control = @car.technical_control.valid_until > Date.today
    @valid_insurance = @car.insurance.assured_until > Date.today
    @interior_materials = JSON.parse(@car.car_option.interior_material)
    @exterior_materials = JSON.parse(@car.car_option.exterior_material)
    @health_score = 80
    # @journeys_by_cars = fetch_journeys_by_cars(@cars)
    # HEALTH SCORE FUNCTION
  end

  def statistics
    @yearly_date = Date.today.year
    @total_cars_worth = calculate_total_cars_worth(@user.cars)
    @cars_number = @user.cars.count
    @total_cars_worth_string = separate_number_with_dots(@total_cars_worth)
    @average_car_mileage = average_car_mileage(@user.cars)
    @average_car_age = average_car_age(@user.cars)
    @total_insurance_costs = calculate_total_insurance_cost(@user.cars)
  end

  def actions 
    # setup warnings for technical control
    # setup insurance reminder 
    # setup maintainance control with a periodicity
  end

  private

  def set_user 
    @user = current_user
  end

  def search_by_model(query)
    query = query.downcase
    cars = Car.where(user_id: @user.id)
  
    return if cars.empty?

    model_names_with_ids = cars.pluck(:model_specific_name, :id).to_h
    brands_with_ids = cars.pluck(:brand, :id).to_h
  
    model_names_with_ids.transform_keys!(&:downcase)
    brands_with_ids.transform_keys!(&:downcase)
  
    model_results = model_names_with_ids.select { |model_name, _id| model_name.include?(query) }
    matched_ids = model_results.values
  
    brand_results = brands_with_ids.select { |brand, _id| brand.include?(query) }
    matched_ids.concat(brand_results.values.flatten) unless brand_results.empty?

    return query = nil if matched_ids.empty?
  
    matched_cars = Car.where(id: matched_ids)
    matched_cars.empty? ? nil : matched_cars
  end
  

  def fetch_journeys_by_cars(cars)
    global_hash = {}

    cars.each do |car|
      next unless car.journeys.any?
    
      car_journeys = { car.id => { car: car, journeys: Journey.where(car_id: car.id).pluck(:id) } }
      global_hash.merge!(car_journeys)
    end

    data_for_chart = global_hash.map do |car_id, car_data|
      {
        name: car_data[:car].model_specific_name,
        data: { "Car #{car_id}" => car_data[:journeys].count }
      }
    end

    return data_for_chart
  end


  def fetch_invalid_cars(cars)
    return unless cars

      cars.select do |car|
        car.technical_control.valid_until <= Date.today
      end
  end

  def fetch_unmaintained_cars(cars)
    return unless cars
  
    selected_cars = cars.select do |car|
      car.maintainance.last_repair_date.year <= Date.today.year - 3 || 
      car.maintainance.maintainance_needed 
    end
  end

  def fetch_uninsured_cars(cars)
    return unless cars

    cars.select do |car|
      car.insurance.assured_until < Date.current
    end
  end

  def calculate_total_insurance_cost(cars)
    return unless cars
  
    total_costs = cars.sum { |car| car.insurance.assurance_price }
  
    separate_number_with_dots(total_costs)
  end

  def average_car_mileage(cars)
    return unless cars && cars.any?
  
    total_mileage = cars.sum(&:mileage)
    average_car_milage = total_mileage / cars.size if total_mileage.positive?
  
    separate_number_with_dots(average_car_milage)
  end
  
  def average_car_age(cars)
    return "No data" unless cars && cars.any?
  
    current_year = Date.today.year
    total_cars_age = cars.sum { |car| current_year - car.model_year }
  
    counter = cars.count
    average_age = (counter > 0) ? (total_cars_age / counter) : 0
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
        :model, :door_number, :specifications, interior_material: [], exterior_material: [], 
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
    params.require(:car).permit(:insurance_attributes).permit(
      :assurance_type, :assured_until, :assurance_price, :assurance_company
    )
  end

  def maintainance_params
    params.require(:car).permit(:maintainance_attributes).permit(
      :maintainance_costs, :maintainance_needed, :drivable, :accidented,
      :major_issues, :maintainance_periodicity, :repair_company, :last_repair_date
    )
  end

  def technical_control_params
    params.require(:car).permit(:technical_control_attributes).permit(
      :technical_control_frequency, :technical_control_price, :control_company,
      :counter_visit_at_last_control, :issues_encountered, :valid_until
    )
  end

  def car_option_params
    params.require(:car).permit(:car_option_attributes).permit(
      :exterior_color, :interior_color, :motricity, :gearbox, :vehicle_type,
      :model, :door_number, :modifications, :modified, :original, :specifications,
      :leather_interior, interior_material: [], exterior_material: []
    )
  end
end
