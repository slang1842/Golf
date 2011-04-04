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

ActiveRecord::Schema.define(:version => 20110401123916) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fields", :force => true do |t|
    t.integer  "golf_club_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "golf_clubs", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",                                               :null => false
    t.integer  "country_id"
    t.string   "region",                                             :null => false
    t.string   "city",                                               :null => false
    t.string   "web_page",                                           :null => false
    t.string   "start_place_by_level_low"
    t.string   "start_place_by_level_medium"
    t.string   "start_place_by_level_high"
    t.string   "accepted",                    :default => "unknown"
    t.boolean  "active",                      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "green_fees", :force => true do |t|
    t.integer  "field_id"
    t.string   "title"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hints", :force => true do |t|
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hit_places", :force => true do |t|
    t.integer  "field_id"
    t.integer  "place"
    t.integer  "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holes", :force => true do |t|
    t.integer  "field_id"
    t.integer  "par"
    t.integer  "hcp"
    t.integer  "white"
    t.integer  "blue"
    t.integer  "red"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "crypted_password",                      :null => false
    t.string   "password_salt",                         :null => false
    t.string   "persistence_token",                     :null => false
    t.boolean  "admin",              :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nick"
    t.string   "sex"
    t.date     "birth"
    t.integer  "country_id"
    t.integer  "golf_club_id"
    t.integer  "hcp"
    t.boolean  "right_handed"
    t.string   "measurement"
    t.integer  "start_place_color"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "login_count",        :default => 0,     :null => false
    t.integer  "failed_login_count", :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

end
