class RemoveRepairReferencesFromMaintainances < ActiveRecord::Migration[7.0]
  def change
    remove_reference :maintainances, :repair, null: false, foreign_key: true
  end
end
