class RemoveMaintainancePeriodictyFromMaintainanances < ActiveRecord::Migration[7.0]
  def change
    remove_column :maintainances, :maintainance_periodicty, :integer
  end
end
