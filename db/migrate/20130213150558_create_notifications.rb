class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :title
      t.text :recipients
      t.text :sound
      t.integer :badge
      t.integer :page_id

      t.timestamps
    end
  end
end
