class CreateCreateCustomChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.integer :parent_id
      t.integer :chore_id
      t.text :chore

      t.timestamps
    end
  end
end
