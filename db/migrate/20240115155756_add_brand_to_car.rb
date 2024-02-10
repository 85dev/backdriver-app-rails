class AddBrandToCar < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :brand, :string
  end
end
