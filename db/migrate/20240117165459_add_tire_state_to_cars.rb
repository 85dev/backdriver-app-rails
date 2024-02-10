class AddTireStateToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :tires_state, :string
  end
end
