class AddActiveToKidsChores < ActiveRecord::Migration
  def change
    add_column :chore_kids , :active, :integer, :default => 1
  end
end
