class RemoveFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :maintenance_costs_since_purchase, :integer
    remove_column :cars, :maintenance_needed, :boolean
    remove_column :cars, :drivable, :boolean
    remove_column :cars, :accidented, :boolean
    remove_column :cars, :major_issues, :string
  end
end

