class AddValueToPoints < ActiveRecord::Migration
  def change
    add_column :points, :points, :integer
  end
end
