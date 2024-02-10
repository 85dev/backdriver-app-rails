class RemoveLotsFromInsurances < ActiveRecord::Migration[7.0]
  def change
    remove_column :insurances, :assured, :boolean
    remove_column :insurances, :assurance_estimation, :integer
  end
end
