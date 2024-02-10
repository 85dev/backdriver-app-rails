class RemoveLotsFromCarOptions < ActiveRecord::Migration[7.0]
  def change
    remove_column :car_options, :modified, :boolean
    remove_column :car_options, :leather_interior, :boolean
    remove_column :car_options, :specific_material, :string
  end
end
