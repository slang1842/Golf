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

ActiveRecord::Schema.define(:version => 20111228083938) do

  create_table "all_stick_statistics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stick_id"
    t.integer  "usage"
    t.integer  "avg_distance"
    t.integer  "stick_progres"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "name",                :null => false
    t.string   "very_short_distance"
    t.string   "short_distance"
    t.string   "normal_distance"
    t.string   "long_distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_filter_statistics", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "field_id"
    t.integer  "hit_sum"
    t.integer  "avg_r_distance"
    t.integer  "avg_p_distance"
    t.integer  "hit_progress"
    t.boolean  "place_teebox",           :default => false
    t.boolean  "place_feairway",         :default => false
    t.boolean  "place_next_fairway",     :default => false
    t.boolean  "place_semi_raf",         :default => false
    t.boolean  "place_raf",              :default => false
    t.boolean  "place_for_green",        :default => false
    t.boolean  "place_green",            :default => false
    t.boolean  "place_fairway_sand",     :default => false
    t.boolean  "place_green_sand",       :default => false
    t.boolean  "place_wood",             :default => false
    t.boolean  "place_from_water",       :default => false
    t.boolean  "stance_normal",          :default => false
    t.boolean  "stance_right_leg_lower", :default => false
    t.boolean  "stance_left_leg_lower",  :default => false
    t.boolean  "stance_ball_lower",      :default => false
    t.boolean  "stance_ball_higher",     :default => false
    t.boolean  "direction_straigth",     :default => false
    t.boolean  "direction_fade",         :default => false
    t.boolean  "direction_drow",         :default => false
    t.boolean  "direction_slice",        :default => false
    t.boolean  "direction_hook",         :default => false
    t.boolean  "temperature_cold",       :default => false
    t.boolean  "temperature_normal",     :default => false
    t.boolean  "temperature_hot",        :default => false
    t.boolean  "weather_normal",         :default => false
    t.boolean  "weather_wind",           :default => false
    t.boolean  "weather_rain",           :default => false
    t.boolean  "weather_wind_and_rain",  :default => false
    t.boolean  "trajectory_normal",      :default => false
    t.boolean  "trajectory_high",        :default => false
    t.boolean  "trajectory_low",         :default => false
    t.boolean  "wind_from_behind",       :default => false
    t.boolean  "wind_from_front",        :default => false
    t.boolean  "wind_from_left",         :default => false
    t.boolean  "wind_from_right",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_statistic_generals", :force => true do |t|
    t.integer  "game_id"
    t.integer  "hit_sum"
    t.integer  "put_sum"
    t.integer  "gir_sum"
    t.integer  "game_progress"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_statistics_by_holes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "field_id"
    t.integer  "hole_id"
    t.integer  "hit_sum"
    t.integer  "gir_sum"
    t.integer  "put_sum"
    t.integer  "hole_number"
    t.integer  "hit_p"
    t.integer  "hit_r"
    t.integer  "puts_p"
    t.integer  "puts_r"
    t.string   "stick_order_p"
    t.string   "stick_order_r"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_statistics_by_sticks", :force => true do |t|
    t.integer  "game_id"
    t.integer  "fields_id"
    t.integer  "users_stick_id"
    t.integer  "user_id"
    t.integer  "hits_p"
    t.integer  "hits_r"
    t.integer  "avg_distance"
    t.integer  "stick_usage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.string   "field_quality"
    t.string   "green_quality"
    t.integer  "temperature"
    t.integer  "weather"
    t.datetime "date"
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
    t.date     "pay_banner_end_date"
    t.boolean  "is_p_banner_disabled",        :default => true
    t.boolean  "is_f_banner_disabled",        :default => true
    t.boolean  "is_v_banner_disabled",        :default => true
    t.string   "image_v_file_name"
    t.string   "image_v_content_type"
    t.integer  "image_v_file_size"
    t.datetime "image_v_updated_at"
    t.string   "image_f_file_name"
    t.string   "image_f_content_type"
    t.integer  "image_f_file_size"
    t.datetime "image_f_updated_at"
    t.string   "image_p_file_name"
    t.string   "image_p_content_type"
    t.integer  "image_p_file_size"
    t.datetime "image_p_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "green_fees", :force => true do |t|
    t.integer  "field_id"
    t.string   "title",      :null => false
    t.string   "price",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hints", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stick_id"
    t.string   "place_teebox_hint"
    t.string   "place_feairway_hint"
    t.string   "place_next_fairway_hint"
    t.string   "place_semi_raf_hint"
    t.string   "place_raf_hint"
    t.string   "place_for_green_hint"
    t.string   "place_green_hint"
    t.string   "place_fairway_sand_hint"
    t.string   "place_green_sand_hint"
    t.string   "place_wood_hint"
    t.string   "place_from_water_hint"
    t.string   "stance_normal_hint"
    t.string   "stance_right_leg_lower_hint"
    t.string   "stance_left_leg_lower_hint"
    t.string   "stance_ball_lower_hint"
    t.string   "stance_ball_higher_hint"
    t.string   "direction_straigth_hint"
    t.string   "direction_fade_hint"
    t.string   "direction_drow_hint"
    t.string   "direction_slice_hint"
    t.string   "direction_hook_hint"
    t.string   "temperature_cold_hint"
    t.string   "temperature_normal_hint"
    t.string   "temperature_hot_hint"
    t.string   "weather_normal_hint"
    t.string   "weather_wind_hint"
    t.string   "weather_rain_hint"
    t.string   "weather_wind_and_rain_hint"
    t.string   "trajectory_normal_hint"
    t.string   "trajectory_high_hint"
    t.string   "trajectory_low_hint"
    t.string   "wind_from_behind_hint"
    t.string   "wind_from_front_hint"
    t.string   "wind_from_left_hint"
    t.string   "wind_from_right_hint"
    t.integer  "green_strength_light_hint"
    t.integer  "green_strength_normal_hint"
    t.integer  "green_strength_strong_hint"
    t.integer  "green_strength_very_strong_hint"
    t.integer  "green_direction_straight_hint"
    t.integer  "green_direction_to_right_hint"
    t.integer  "green_direction_to_left_hint"
    t.integer  "green_direction_more_to_right_hint"
    t.integer  "green_direction_more_to_left_hint"
    t.integer  "green_tilt_straight_hint"
    t.integer  "green_tilt_upward_hint"
    t.integer  "green_tilt_downward_hint"
    t.integer  "green_tilt_very_upward_hint"
    t.integer  "green_tilt_very_downward_hint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hit_places", :force => true do |t|
    t.integer  "field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hits", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "hole_id"
    t.integer  "stick_id"
    t.string   "real_hit"
    t.integer  "hole_number"
    t.integer  "hit_number"
    t.integer  "place_from"
    t.integer  "land_place"
    t.integer  "stance"
    t.integer  "trajectory"
    t.boolean  "luck_factor"
    t.string   "comment"
    t.integer  "following_action"
    t.float    "distance_to_hole"
    t.float    "hit_distance"
    t.integer  "wind"
    t.integer  "hit_was"
    t.integer  "motion_was"
    t.integer  "direction"
    t.integer  "misdirection"
    t.integer  "pair_id"
    t.integer  "difficulty"
    t.string   "hole_comment"
    t.integer  "slipums"
    t.integer  "kritums"
    t.integer  "strength"
    t.integer  "mistake"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holes", :force => true do |t|
    t.integer  "field_id"
    t.integer  "par",                 :null => false
    t.integer  "hcp",                 :null => false
    t.integer  "hole_number",         :null => false
    t.float    "distance"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "very_short_distance"
    t.float    "short_distance"
    t.float    "normal_distance"
    t.float    "long_distance"
  end

  create_table "pair_hits", :force => true do |t|
    t.integer  "hit_planed_id"
    t.integer  "hit_real_id"
    t.integer  "users_stick_id"
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistic_user_progres", :force => true do |t|
    t.integer  "user_id"
    t.integer  "field_id"
    t.integer  "hcp"
    t.integer  "user_progress"
    t.integer  "max_distance"
    t.integer  "num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistics", :force => true do |t|
    t.integer  "game_id"
    t.integer  "field_id"
    t.integer  "user_id"
    t.integer  "stick_id"
    t.integer  "place_teebox"
    t.integer  "place_feairway"
    t.integer  "place_next_fairway"
    t.integer  "place_semi_raf"
    t.integer  "place_raf"
    t.integer  "place_for_green"
    t.integer  "place_green"
    t.integer  "place_fairway_sand"
    t.integer  "place_green_sand"
    t.integer  "place_wood"
    t.integer  "place_from_water"
    t.integer  "stance_normal"
    t.integer  "stance_right_leg_lower"
    t.integer  "stance_left_leg_lower"
    t.integer  "stance_ball_lower"
    t.integer  "stance_ball_higher"
    t.integer  "direction_straigth"
    t.integer  "direction_fade"
    t.integer  "direction_drow"
    t.integer  "direction_slice"
    t.integer  "direction_hook"
    t.integer  "temperature_cold"
    t.integer  "temperature_normal"
    t.integer  "temperature_hot"
    t.integer  "weather_normal"
    t.integer  "weather_wind"
    t.integer  "weather_rain"
    t.integer  "weather_wind_and_rain"
    t.integer  "trajectory_normal"
    t.integer  "trajectory_high"
    t.integer  "trajectory_low"
    t.integer  "wind_from_behind"
    t.integer  "wind_from_front"
    t.integer  "wind_from_left"
    t.integer  "wind_from_right"
    t.integer  "green_strength_light"
    t.integer  "green_strength_normal"
    t.integer  "green_strength_strong"
    t.integer  "green_strength_very_strong"
    t.integer  "green_direction_straight"
    t.integer  "green_direction_to_right"
    t.integer  "green_direction_to_left"
    t.integer  "green_direction_more_to_right"
    t.integer  "green_direction_more_to_left"
    t.integer  "green_tilt_straight"
    t.integer  "green_tilt_upward"
    t.integer  "green_tilt_downward"
    t.integer  "green_tilt_very_upward"
    t.integer  "green_tilt_very_downward"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sticks", :force => true do |t|
    t.string   "stick_type",     :null => false
    t.float    "distance",       :null => false
    t.integer  "degrees",        :null => false
    t.string   "shaft",          :null => false
    t.string   "shaft_strength", :null => false
    t.string   "short_name",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "crypted_password",                      :null => false
    t.string   "password_salt",                         :null => false
    t.string   "persistence_token",                     :null => false
    t.boolean  "new_user",           :default => true
    t.boolean  "add_club",           :default => false
    t.boolean  "admin",              :default => false
    t.boolean  "is_super_admin",     :default => false
    t.boolean  "is_blocked",         :default => false
    t.integer  "coach"
    t.string   "first_name",                            :null => false
    t.string   "last_name",                             :null => false
    t.string   "nick",                                  :null => false
    t.string   "sex",                                   :null => false
    t.date     "birth"
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
    t.float    "distance",       :null => false
    t.string   "degrees",        :null => false
    t.string   "shaft",          :null => false
    t.string   "shaft_strength", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
