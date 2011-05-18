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

ActiveRecord::Schema.define(:version => 20110427094148) do

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
    t.string   "green_quality"
    t.integer  "temperature"
    t.integer  "weather"
    t.time     "date"
    t.string   "game_format"
    t.integer  "user_id"
    t.integer  "field_id"
    t.integer  "game_type"
    t.integer  "start_place_colors"
    t.string   "comment"
    t.string   "hit_direction"
    t.integer  "next_hole"
    t.integer  "active_hit"
    t.string   "form"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "golf_clubs", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",                                               :null => false
    t.integer  "country_id",                                         :null => false
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
    t.integer  "stick_id"
    t.integer  "users_stick_id"
    t.string   "stick_type"
    t.string   "real_hit"
    t.integer  "hole_number"
    t.integer  "hit_number"
    t.integer  "place_from"
    t.integer  "land_place"
    t.integer  "stance"
    t.integer  "trajectory"
    t.string   "put_or_hit"
    t.boolean  "luck_factor"
    t.string   "comment"
    t.integer  "following_action"
    t.integer  "distance_to_hole"
    t.integer  "hit_distance"
    t.integer  "wind"
    t.string   "hit_was"
    t.string   "motion_was"
    t.integer  "direction"
    t.integer  "misdirection"
    t.integer  "pair_id"
    t.integer  "difficulty"
    t.string   "hole_comment"
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
    t.integer  "hole_number",        :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pair_hits", :force => true do |t|
    t.integer  "hit_planed_id"
    t.integer  "hit_real_id"
    t.integer  "users_stick_id"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stick_id"
    t.string   "place_teebox"
    t.integer  "place_teebox_hint_id"
    t.string   "place_feairway"
    t.integer  "place_feairway_hint_id"
    t.string   "place_next_fairway"
    t.integer  "place_next_fairway_hint_id"
    t.string   "place_semi_raf"
    t.integer  "place_semi_raf_hint_id"
    t.string   "place_raf"
    t.integer  "place_raf_hint_id"
    t.string   "place_for_green"
    t.integer  "place_for_green_hint_id"
    t.string   "place_green"
    t.integer  "place_green_hint_id"
    t.string   "place_fairway_sand"
    t.integer  "place_fairway_sand_hint_id"
    t.string   "place_green_sand"
    t.integer  "place_green_sand_hint_id"
    t.string   "place_wood"
    t.integer  "place_wood_hint_id"
    t.string   "place_from_water"
    t.integer  "place_from_water_hint_id"
    t.string   "stance_normal"
    t.integer  "stance_normal_hint_id"
    t.string   "stance_right_leg_lower"
    t.integer  "stance_right_leg_lower_hint_id"
    t.string   "stance_left_leg_lower"
    t.integer  "stance_left_leg_lower_hint_id"
    t.string   "stance_ball_lower"
    t.integer  "stance_ball_lower_hint_id"
    t.string   "stance_ball_higher"
    t.integer  "stance_ball_higher_hint_id"
    t.string   "direction_straigth"
    t.integer  "direction_straigth_hint_id"
    t.string   "direction_fade"
    t.integer  "direction_fade_hint_id"
    t.string   "direction_drow"
    t.integer  "direction_drow_hint_id"
    t.string   "direction_slice"
    t.integer  "direction_slice_hint_id"
    t.string   "direction_hook"
    t.integer  "direction_hook_hint_id"
    t.string   "temperature_cold"
    t.integer  "temperature_cold_hint_id"
    t.string   "temperature_normal"
    t.integer  "temperature_normal_hint_id"
    t.string   "temperature_hot"
    t.integer  "temperature_hot_hint_id"
    t.string   "weather_normal"
    t.integer  "weather_normal_hint_id"
    t.string   "weather_wind"
    t.integer  "weather_wind_hint_id"
    t.string   "weather_rain"
    t.integer  "weather_rain_hint_id"
    t.string   "weather_wind_and_rain"
    t.integer  "weather_wind_and_rain_hint_id"
    t.string   "trajectory_normal"
    t.integer  "trajectory_normal_hint_id"
    t.string   "trajectory_high"
    t.integer  "trajectory_high_hint_id"
    t.string   "trajectory_low"
    t.integer  "trajectory_low_hint_id"
    t.string   "wind_from_behind"
    t.integer  "wind_from_behind_hint_id"
    t.string   "wind_from_front"
    t.integer  "wind_from_front_hint_id"
    t.string   "wind_from_left"
    t.integer  "wind_from_left_hint_id"
    t.string   "wind_from_right"
    t.integer  "wind_from_right_hint_id"
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
    t.integer  "country_id"
    t.integer  "golf_club_id"
    t.integer  "hcp",                                   :null => false
    t.boolean  "right_handed",                          :null => false
    t.string   "measurement",                           :null => false
    t.integer  "start_place_color",                     :null => false
    t.string   "temp_preference",                       :null => false
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
    t.integer  "pair_hit_id"
    t.string   "distance",       :null => false
    t.string   "degrees",        :null => false
    t.string   "shaft",          :null => false
    t.string   "shaft_strength", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
