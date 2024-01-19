class RemoveTireSizesFromCarsAndManyOtherThings < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :tire_size_front, :integer
    remove_column :cars, :tire_size_back, :integer
    remove_column :cars, :din_power, :integer
  end
end
