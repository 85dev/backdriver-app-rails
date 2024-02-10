class AddMotricityToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :motricity, :string
  end
end
