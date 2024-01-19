class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.integer :model_year
      t.date :release_date
      t.string :brand
      t.string :fuel
      t.integer :motricity
      t.string :gearbox
      t.string :vehicle_type
      t.string :model
      t.integer :door_number
      t.integer :fiscal_power
      t.string :required_licence
      t.integer :din_power
      t.integer :horse_power
      t.integer :seats
      t.date :acquisition_date
      t.integer :owners_number
      t.integer :tire_size_front
      t.integer :tire_size_back
      t.integer :mileage
      t.integer :purchase_price
      t.integer :estimated_value
      t.string :geolocalisation
      t.integer :maintenance_costs_since_purchase
      t.boolean :maintenance_needed
      t.boolean :drivable
      t.boolean :accidented
      t.string :major_issues
      t.boolean :to_sell
      t.date :last_time_driven

      t.timestamps
    end
  end
end
