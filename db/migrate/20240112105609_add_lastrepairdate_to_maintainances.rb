class AddLastrepairdateToMaintainances < ActiveRecord::Migration[7.0]
  def change
    add_column :maintainances, :last_repair_date, :date
  end
end
