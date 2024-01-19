class RemoveBrandFromCar < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :brand, :string
  end
end
