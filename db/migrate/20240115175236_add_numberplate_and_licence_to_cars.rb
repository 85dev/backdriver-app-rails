class AddNumberplateAndLicenceToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :numberplate, :string
    add_column :cars, :licence, :string
  end
end
