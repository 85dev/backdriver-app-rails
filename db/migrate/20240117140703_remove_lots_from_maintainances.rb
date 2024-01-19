class RemoveLotsFromMaintainances < ActiveRecord::Migration[7.0]
  def change
    remove_column :maintainances, :drivable, :boolean
    remove_column :maintainances, :major_issues, :string
  end
end
