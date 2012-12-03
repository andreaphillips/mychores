class AddCountryAndLanguageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :language, :string
  end
end
