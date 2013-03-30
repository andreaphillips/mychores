class CreateCreateCustomChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.references :user
      t.integer :chore_id
      t.text :chore
      t.binary :picture

      t.timestamps
    end
  end
end
