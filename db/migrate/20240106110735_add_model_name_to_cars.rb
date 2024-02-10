class AddModelNameToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :model_specific_name, :string
  end
end
