class AddMaintainancePeriodicityToMaintainances < ActiveRecord::Migration[7.0]
  def change
    add_column :maintainances, :maintainance_periodicity, :date
  end
end
