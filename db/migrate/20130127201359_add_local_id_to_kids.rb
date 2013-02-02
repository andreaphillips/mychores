class AddLocalIdToKids < ActiveRecord::Migration
  def change
    add_column :kids, :local_id, :integer
  end
end
