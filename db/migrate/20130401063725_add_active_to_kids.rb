class AddActiveToKids < ActiveRecord::Migration
  def change
    add_column :kids , :active, :integer, :default => 1

  end
end
