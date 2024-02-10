class CreateMaintainances < ActiveRecord::Migration[7.0]
  def change
    create_table :maintainances do |t|
      t.references :car, null: false, foreign_key: true
      t.integer :maintainance_costs
      t.boolean :maintainance_needed
      t.boolean :drivable
      t.boolean :accidented
      t.string :major_issues
      t.integer :maintainance_periodicty
      t.string :repair_company

      t.timestamps
    end
  end
end
