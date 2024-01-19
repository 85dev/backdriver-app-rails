class AddPurchasePriceToCars3 < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :purchase_price, :string
  end
end
