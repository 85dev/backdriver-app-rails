class AddLotsToMaintainances < ActiveRecord::Migration[7.0]
  def change
    add_reference :maintainances, :repair, null: false, foreign_key: true
    add_column :maintainances, :repair_history, :string
  end
end
