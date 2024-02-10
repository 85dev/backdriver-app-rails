class AddLotsToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :selling_price, :integer
    add_column :cars, :sold, :boolean
    add_column :cars, :interior_state, :string
    add_column :cars, :exterior_state, :string
    add_column :cars, :drive_count_since_acquisition, :integer
    add_column :cars, :journey_taken, :integer
    add_column :cars, :regularly_maintained, :boolean
  end
end
