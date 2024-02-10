class RemoveMaintainancePeriodicityFromMaintainances < ActiveRecord::Migration[7.0]
  def change
    remove_column :maintainances, :maintainance_periodicity, :date
  end
end
