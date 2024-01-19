class RemovePurchasePriceFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :purchase_price, :integer
  end
end
