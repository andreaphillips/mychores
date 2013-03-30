class CreatePoints < ActiveRecord::Migration
  def up
    create_table :points do |t|
      t.integer :chore_id
      t.references :kid
      t.references :user
      t.date :date

      t.timestamps
    end
  end

  def down
    drop_table :points
  end
end
