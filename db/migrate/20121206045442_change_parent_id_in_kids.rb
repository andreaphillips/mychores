class ChangeParentIdInKids < ActiveRecord::Migration
  def up
    change_column(:kids,:parent_id,:string)
  end

  def down
  end
end
