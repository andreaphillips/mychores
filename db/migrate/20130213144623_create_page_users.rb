class CreatePageUsers < ActiveRecord::Migration
  def change
    create_table :page_users do |t|
      t.string :device_token
      t.integer :page_id
      t.boolean :read
      t.boolean :deleted

      t.timestamps
    end
  end
end
