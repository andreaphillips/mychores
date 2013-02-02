class ChangeChoreIdToLocalChoreId < ActiveRecord::Migration
  def up
    rename_column :chores, :chore_id, :local_chore_id
  end

  def down
  end
end
