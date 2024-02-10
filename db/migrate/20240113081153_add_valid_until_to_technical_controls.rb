class AddValidUntilToTechnicalControls < ActiveRecord::Migration[7.0]
  def change
    add_column :technical_controls, :valid_until, :date
  end
end
