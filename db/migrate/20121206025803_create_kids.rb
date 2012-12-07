class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.text :name
      t.text :sex
      t.integer :age
      t.integer :parent_id
      t.integer :chore_amount
      t.integer :reward_percent
      t.binary :picture

      t.timestamps
    end
  end
end