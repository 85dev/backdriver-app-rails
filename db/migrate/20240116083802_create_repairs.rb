class CreateRepairs < ActiveRecord::Migration[7.0]
  def change
    create_table :repairs do |t|
      t.references :car, null: false, foreign_key: true
      t.integer :repair_cost
      t.string :repair_company
      t.string :repair_topic

      t.timestamps
    end
  end
end
