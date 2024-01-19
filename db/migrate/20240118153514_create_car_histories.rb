class CreateCarHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :car_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :total_sold_cars_value
      t.integer :cars_sold

      t.timestamps
    end
  end
end
