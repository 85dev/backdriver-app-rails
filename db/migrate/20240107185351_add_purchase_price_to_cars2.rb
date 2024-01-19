class AddPurchasePriceToCars2 < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :purchase_price, :integer
  end
end
