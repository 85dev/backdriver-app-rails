class RemoveLicenceFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :licence, :string
  end
end
