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

ActiveRecord::Schema.define(:version => 20110414125341) do

  create_table "balls", :force => true do |t|
    t.integer  "user_id"
    t.string   "ball_manufacturer"
    t.string   "ball_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fields", :force => true do |t|
    t.integer  "golf_club_id"
    t.string   "name",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.string   "field_quality"
    t.string   "temperature"
    t.string   "weather"
    t.time     "date"
    t.string   "game_format"
    t.integer  "user_id"
    t.integer  "field_id"
    t.string   "game_type"
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
    t.string   "title",      :null => false
    t.integer  "price",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hints", :force => true do |t|
    t.integer  "user_id"
    t.string   "text",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hit_places", :force => true do |t|
    t.integer  "field_id"
    t.integer  "place",      :null => false
    t.integer  "color",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hits", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "hole_id"
    t.integer  "user_stick_id"
    t.boolean  "real_hit"
    t.integer  "hits"
    t.integer  "puts"
    t.string   "follow_up"
    t.string   "stance"
    t.integer  "hardness"
    t.string   "motion"
    t.string   "hit_type"
    t.string   "luck_factor"
    t.string   "comment"
    t.integer  "distance_to_hole_land"
    t.integer  "distance_to_hole_hit"
    t.integer  "distance_to_hole_left"
    t.integer  "hole_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holes", :force => true do |t|
    t.integer  "field_id"
    t.integer  "par",                :null => false
    t.integer  "hcp",                :null => false
    t.integer  "white",              :null => false
    t.integer  "blue",               :null => false
    t.integer  "red",                :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sticks", :force => true do |t|
    t.string   "stick_type",     :null => false
    t.integer  "distance",       :null => false
    t.integer  "degrees",        :null => false
    t.string   "shaft",          :null => false
    t.string   "shaft_strength", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "crypted_password",                      :null => false
    t.string   "password_salt",                         :null => false
    t.string   "persistence_token",                     :null => false
    t.boolean  "admin",              :default => false
    t.boolean  "is_super_admin",     :default => false
    t.boolean  "is_blocked",         :default => false
    t.string   "first_name",                            :null => false
    t.string   "last_name",                             :null => false
    t.string   "nick",                                  :null => false
    t.string   "sex",                                   :null => false
    t.date     "birth",                                 :null => false
    t.integer  "country_id",                            :null => false
    t.integer  "golf_club_id"
    t.integer  "hcp",                                   :null => false
    t.boolean  "right_handed",                          :null => false
    t.string   "measurement",                           :null => false
    t.integer  "start_place_color",                     :null => false
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

  create_table "users_sticks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stick_id"
    t.string   "distance",       :null => false
    t.string   "degrees",        :null => false
    t.string   "shaft",          :null => false
    t.string   "shaft_strength", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
