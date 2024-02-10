class Car < ApplicationRecord
    belongs_to :user
    has_one_attached :photo

    # TABLES ASSOCIATIONS

    has_one :maintainance, dependent: :destroy
    has_one :insurance, dependent: :destroy
    has_one :technical_control, dependent: :destroy
    has_one :car_option, dependent: :destroy
    has_many :repairs, dependent: :destroy
    has_many :journeys, dependent: :destroy

    accepts_nested_attributes_for :maintainance, allow_destroy: true
    accepts_nested_attributes_for :insurance, allow_destroy: true
    accepts_nested_attributes_for :technical_control, allow_destroy: true
    accepts_nested_attributes_for :car_option, allow_destroy: true
    accepts_nested_attributes_for :repairs, allow_destroy: true

    # VALIDATIONS

    # validates :model_year, presence: true, numericality: { only_integer: true }
    # validates :release_date, presence: true
    # validates :fuel, presence: true
    # validates :vehicle_type, presence: true
    # validates :fiscal_power, presence: true, numericality: { only_integer: true }
    # validates :required_licence, presence: true    
    # validates :horse_power, presence: true, numericality: { only_integer: true }
    # validates :seats, presence: true, numericality: { only_integer: true }
    # validates :acquisition_date, presence: true
    # validates :owners_number, presence: true, numericality: { only_integer: true }
    # validates :mileage, presence: true, numericality: { only_integer: true }
    # validates :to_sell, inclusion: { in: [true, false] }
    # validates :last_time_driven, presence: true
    # validates :model_specific_name, presence: true
    # validates :purchase_price, presence: true
    # validates :brand, presence: true
    # validates :numberplate, presence: true

    VEHICLE_TYPE_OPTIONS = ["Break", "SUV", "Truck", "Convertible", "Van", "Coupe", "Wagon", "Hatchback", "Spyder", "Other"].freeze
    FUEL_OPTIONS = ["Gasoline", "Diesel", "Electric", "Hybrid", "Other"].freeze
    INTERIOR_OPTIONS = ["Leather", "Velvet", "Wood", "Alcantara", "Silk", "Cashmere", "Wool"].freeze
    EXTERIOR_OPTIONS = ["Carbon", "Aluminium", "Titanium", "Kevlar", "Fiberglass", "Plastic", "Stainless Steel", "Chrome"].freeze
    CAR_CONDITION_STATES = ["Bad", "Average", "Good", "Excellent"].freeze
    INSURANCE_OPTIONS= ["Tout-risque", "Collection", "Au tiers", "Vol et dégradations"].freeze
    TIRE_STATES = ["Excellent", "Good", "Average", "Bad", "Worn out"].freeze
    GEARBOX_OPTIONS = ["Automatic", "Manual", "Semi-automatic", "Sequential", "Tiptronic", "Electric", "Other"].freeze
    MOTRICITY_OPTIONS = [
        "Front Traction",
        "Rear Traction",
        "Four-Wheel Traction (4x4)",
        "Selectable Traction"
      ]
    BRAND_OPTIONS = [
        "Abarth",
        "Alfa Romeo",
        "Aston Martin",
        "Audi",
        "Bentley",
        "BMW",
        "Bugatti",
        "Cadillac",
        "Chevrolet",
        "Chrysler",
        "Citroën",
        "Dacia",
        "Daewoo",
        "Daihatsu",
        "Dodge",
        "Donkervoort",
        "DS",
        "Ferrari",
        "Fiat",
        "Fisker",
        "Ford",
        "Honda",
        "Hummer",
        "Hyundai",
        "Infiniti",
        "Iveco",
        "Jaguar",
        "Jeep",
        "Kia",
        "KTM",
        "Lada",
        "Lamborghini",
        "Lancia",
        "Land Rover",
        "Landwind",
        "Lexus",
        "Lotus",
        "Maserati",
        "Maybach",
        "Mazda",
        "McLaren",
        "Mercedes-Benz",
        "MG",
        "Mini",
        "Mitsubishi",
        "Morgan",
        "Nissan",
        "Opel",
        "Peugeot",
        "Porsche",
        "Renault",
        "Rolls-Royce",
        "Rover",
        "Saab",
        "Seat",
        "Skoda",
        "Smart",
        "SsangYong",
        "Subaru",
        "Suzuki",
        "Tesla",
        "Toyota",
        "Volkswagen",
        "Volvo",
        "n/a"
    ].freeze
    LICENCE_OPTIONS = ["Permis Auto - B", "Permis Poids Lourd - C", "Permis Bus - D", "Permis Cyclomoteur - AM", "Permis Moto - A"].freeze
end
