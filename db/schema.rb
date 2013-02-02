# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130201045106) do

  create_table "chores", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "local_chore_id"
    t.text     "chore"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "kids", :force => true do |t|
    t.text     "name"
    t.text     "sex"
    t.integer  "age"
    t.string   "parent_id"
    t.integer  "chore_amount"
    t.integer  "reward_percent"
    t.binary   "picture"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "local_id"
  end

  create_table "points", :force => true do |t|
    t.integer  "chore_id"
    t.integer  "kid_id"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "points"
    t.string   "parent_id"
  end

  create_table "users", :force => true do |t|
    t.string   "cloud_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "pass_code"
    t.string   "fb_user"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "country"
    t.string   "language"
  end

end
