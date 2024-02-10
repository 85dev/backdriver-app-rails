class RemovePurchasePriceFromCars2 < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :purchase_price, :string
  end
end
