class ChoresKids < ActiveRecord::Migration
  def change
    create_table :chore_kids do |t|
      t.references :kid
      t.references :chore
      t.date :begin
      t.date :end

      t.timestamps
    end
  end
end
