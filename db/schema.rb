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

ActiveRecord::Schema.define(:version => 20130329220947) do

  create_table "chores", :force => true do |t|
    t.integer  "user_id"
    t.integer  "local_chore_id"
    t.text     "chore"
    t.binary   "picture"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "devices", :force => true do |t|
    t.string   "identifier"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kids", :force => true do |t|
    t.text     "name"
    t.text     "sex"
    t.integer  "age"
    t.integer  "user_id"
    t.integer  "chore_amount"
    t.integer  "reward_percent"
    t.binary   "picture"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "local_id"
  end

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "notifications", :force => true do |t|
    t.text     "title"
    t.text     "recipients"
    t.text     "sound"
    t.integer  "badge"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "page_users", :force => true do |t|
    t.string   "device_token"
    t.integer  "page_id"
    t.boolean  "read",         :default => false
    t.boolean  "deleted",      :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "user_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "points", :force => true do |t|
    t.integer  "chore_id"
    t.integer  "kid_id"
    t.integer  "user_id"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "points"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "pass_code"
    t.boolean  "admin",      :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "country"
    t.string   "language"
    t.boolean  "active",     :default => true
  end

end
