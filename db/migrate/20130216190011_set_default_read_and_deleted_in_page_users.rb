class SetDefaultReadAndDeletedInPageUsers < ActiveRecord::Migration
  def up
    change_column :page_users, :read, :boolean, :default => false
    change_column :page_users, :deleted, :boolean, :default => false

  end

  def down
  end
end
