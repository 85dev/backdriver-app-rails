class CreateTechnicalControls < ActiveRecord::Migration[7.0]
  def change
    create_table :technical_controls do |t|
      t.references :car, null: false, foreign_key: true
      t.integer :technical_control_validity_period
      t.integer :technical_control_frequency
      t.decimal :technical_control_price
      t.string :control_company
      t.boolean :counter_visit_at_last_control
      t.string :issues_encountered

      t.timestamps
    end
  end
end
