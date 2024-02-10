class AddLotsToCarOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :car_options, :interior_material, :string
    add_column :car_options, :exterior_material, :string
  end
end
