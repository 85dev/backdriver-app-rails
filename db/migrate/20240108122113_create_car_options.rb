class CreateCarOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :car_options do |t|
      t.string :exterior_color
      t.string :interior_color
      t.string :motricity
      t.string :gearbox
      t.string :vehicle_type
      t.string :model
      t.integer :door_number
      t.string :modifications
      t.boolean :modified
      t.string :original
      t.string :specifications
      t.boolean :leather_interior
      t.string :specific_material
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
