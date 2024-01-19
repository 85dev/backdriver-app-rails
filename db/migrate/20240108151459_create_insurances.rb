class CreateInsurances < ActiveRecord::Migration[7.0]
  def change
    create_table :insurances do |t|
      t.references :car, null: false, foreign_key: true
      t.boolean :assured
      t.string :assurance_type
      t.date :assured_until
      t.integer :assurance_price
      t.string :assurance_company
      t.integer :assurance_estimation

      t.timestamps
    end
  end
end
