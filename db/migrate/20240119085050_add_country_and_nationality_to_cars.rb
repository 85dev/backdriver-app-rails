class AddCountryAndNationalityToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :country_of_acquisition, :string
    add_column :cars, :current_nationality, :string
    add_column :cars, :produced_for_country, :string
  end
end
