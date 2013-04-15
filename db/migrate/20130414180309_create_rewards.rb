class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.references :kid
      t.date :begin
      t.date :end
      t.string :reward
      t.timestamps
    end
  end
end
