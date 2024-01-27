class RemoveOriginalFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :car_options, :original, :string
  end
end
