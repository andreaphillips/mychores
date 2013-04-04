class AddActiveToDevices < ActiveRecord::Migration
  def change
    add_column :devices , :active, :integer, :default => 1
  end
end
