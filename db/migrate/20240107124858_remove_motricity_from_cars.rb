class RemoveMotricityFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :motricity, :integer
  end
end
