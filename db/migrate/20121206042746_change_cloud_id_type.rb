class ChangeCloudIdType < ActiveRecord::Migration
  def up
    change_column(:users,:cloud_id,:string)
  end

  def down
  end
end
