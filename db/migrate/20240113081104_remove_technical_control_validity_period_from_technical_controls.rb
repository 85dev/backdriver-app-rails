class RemoveTechnicalControlValidityPeriodFromTechnicalControls < ActiveRecord::Migration[7.0]
  def change
    remove_column :technical_controls, :technical_control_validity_period, :integer
  end
end
