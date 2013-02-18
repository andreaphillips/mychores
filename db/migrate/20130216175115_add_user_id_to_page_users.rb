class AddUserIdToPageUsers < ActiveRecord::Migration
  def change
    add_column :page_users , :user_id, :integer
  end
end
