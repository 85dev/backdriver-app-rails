class RemoveLotsFromTechnicalControl < ActiveRecord::Migration[7.0]
  def change
    remove_column :technical_controls, :counter_visit_at_last_control, :boolean
    remove_column :technical_controls, :issues_encountered, :string
  end
end
