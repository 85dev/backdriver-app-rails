class CreateJourneys < ActiveRecord::Migration[7.0]
  def change
    create_table :journeys do |t|
      t.references :car, null: false, foreign_key: true
      t.datetime :date
      t.float :mileage

      t.timestamps
    end
  end
end
