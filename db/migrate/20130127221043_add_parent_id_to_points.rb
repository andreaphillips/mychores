class AddParentIdToPoints < ActiveRecord::Migration
  def change
    add_column :points, :parent_id, :string
  end
end
