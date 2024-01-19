# db/seeds.rb

puts "Cleaning seeds..."

Insurance.destroy_all
Maintainance.destroy_all
CarOption.destroy_all
TechnicalControl.destroy_all
Car.destroy_all

user = User.first

brands = [
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
]

# Variables for seed creation
gearboxes = ["Manual", "Automatic", "Sequential"]
fuels = ["Gasoline", "Diesel", "Electric", "Ethanol", "Hydrogen", "Hybrid"]
true_or_false = [false, true]
door_numbers = [3, 5]
fiscal_power = rand(5..40)
horse_power = rand(70..700)
mileage = rand(1000..250000)
purchase_price = rand(2000..200000)
estimated_value = rand(1000..300000)
models = ["Coupé", "Break", "Berline", "Spyder", "Compact", "SUV", "Sport", "Racing"]
motricity = ["Traction", "Propulsion", "4x4"]
insurances = ["Tout-risque","Collection","Au tiers", "Vol et dégradations"]
repair_topics = [
  "Crankshaft",
  "Axles",
  "Oil Change",
  "Engine Issues",
  "Tires",
  "Brakes",
  "Suspension",
  "Steering",
  "Exhaust",
  "Transmission",
  "Cooling System",
  "Electrical System",
  "Lighting",
  "Body",
  "Interior",
  "Fuel System",
  "Heating and Air Conditioning",
  "Brake Fluid",
  "Power Steering Fluid",
  "Automatic Transmission Fluid",
  "Belts",
  "Filters",
  "Ignition System",
  "Battery",
  "Alternator",
  "Starter",
  "Emission Control System",
  "Catalytic Converter",
  "Wheel Bearings",
  "Anti-lock Braking System - ABS",
  "Tire Pressure Monitoring System - TPMS",
  "Air Suspension System",
  "Head Gasket",
  "Fuel Injection System",
  "Sensors",
  "Navigation System",
  "Glass and Mirrors",
  "Electronic Defects",
  "Starting Problems",
  "Transmission Problems",
  "Immobilizer System",
  "Central Locking System",
  "Cold Start Problems",
  "Engine Management System",
  "Traction Control System",
  "Fluid Leakage",
  "Air Conditioning Problems",
  "Catalytic Exhaust System",
  "Power Steering System",
  "Engine Cooling Problems",
  "Cruise Control System",
  "Blind Spot Monitoring System",
  "Door Closing Problems",
  "Parking Assistance System",
  "Collision Detection System",
  "Oil Pressure Monitoring System",
  "Four-Wheel Drive System",
  "Brake Light Illumination Problems",
  "Electronic Stability Control - ESC",
  "Clutch Problems",
  "Transmission Control System",
  "Heating System",
  "Secondary Air Injection System",
  "Emissions Control System"
]

puts "Seeding car models..."

# Seed data for the Car model
30.times do
  Car.create!(
    user: user,
    brand: brands.sample,
    vehicle_type: models.sample, 
    model_specific_name: "#{models.sample}" +  " " + "#{["Xdrive", "Msport", "GT", "AMG", "RS", "4x4"].sample}",
    model_year: rand(1960..2023),
    release_date: Date.new(rand(1960..2023), rand(1..12), rand(1..30)),
    fuel: fuels.sample,
    fiscal_power: fiscal_power,
    required_licence: ["Permis B", "BER", "Permis poids-lourds"].sample,
    horse_power: horse_power,
    seats: [2,4,5,7].sample,
    acquisition_date: Date.new(rand(1990..2023), rand(1..12), rand(1..29)),
    owners_number: rand(1..10),
    mileage: mileage,
    purchase_price: purchase_price,
    estimated_value: estimated_value,
    geolocalisation: "#{rand(30.0..40.0)}, #{rand(-80.0..-70.0)}",
    to_sell: true_or_false.sample,
    last_time_driven: Date.new(rand(2000..2023), rand(1..12), rand(1..30)),
    numberplate: "QG-#{rand(1..999)}-TR",
    selling_price: rand(10000..200000),
    journey_taken: rand(2000..50000),
    regularly_maintained: true_or_false.sample
  )
end

cars = Car.all

puts "Seeding maintainance & car options..."

cars.each do |car|
  Maintainance.create!(
    car_id: car.id,
    maintainance_costs: rand(0..25000),
    maintainance_needed: true_or_false.sample,
    accidented: true_or_false.sample,
    maintainance_periodicity: Date.new(rand(2010..2025), rand(1..12), rand(1..30)),
    repair_company: brands.sample,
    last_repair_date: Date.new(rand(2010..2025), rand(1..12), rand(1..30)),
  )
  CarOption.create!(
    car_id: car.id,
    door_number: door_numbers.sample,
    motricity: motricity.sample,
    gearbox: gearboxes.sample,
    exterior_color: ["Blue", "Red", "Green", "Yellow"].sample,
    interior_color: ["Black", "Red", "Green", "Yellow"].sample,
    modifications: "None",
    interior_material: ["Alcantara", "Plastic"].sample,
    exterior_material: ["Aluminium", "Carbon"].sample,
  )
  TechnicalControl.create!(
    car_id: car.id,
    valid_until: Date.new(rand(2022..2028), rand(1..12), rand(1..30)),
    technical_control_frequency: rand(1..5),
    technical_control_price: rand(60..90),
    control_company: brands.sample,
  )  
  Insurance.create!(
    car_id: car.id,
    assurance_type: insurances.sample,
    assured_until: Date.new(rand(2024..2025), rand(9..12), rand(1..30)),
    assurance_price: rand(300..1200),
    assurance_company: ["Allianz", "AXA", "Matmut", "Crédit Mutuel", "CIC"].sample,
  )
  Repair.create!(
    car_id: car.id,
    repair_cost: rand(20..3000),
    repair_company: brands.sample,
    repair_topic: repair_topics.sample(3)
  )
end

puts 'Seeds successfully created'
