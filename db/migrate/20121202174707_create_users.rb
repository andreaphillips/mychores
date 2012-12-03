class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :cloud_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :pass_code
      t.string :fb_user

      t.timestamps
    end
  end
end
