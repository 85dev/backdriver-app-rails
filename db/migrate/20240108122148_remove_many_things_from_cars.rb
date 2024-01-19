class RemoveManyThingsFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :door_number, :integer
    remove_column :cars, :gearbox, :string
    remove_column :cars, :motricity, :string
    remove_column :cars, :model, :string
  end
end
