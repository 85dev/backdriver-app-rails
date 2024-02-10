class RemoveModificationsFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :car_options, :modifications, :string
  end
end
