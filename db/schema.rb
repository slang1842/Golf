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

ActiveRecord::Schema.define(:version => 20120308134456) do

  create_table "all_stick_statistics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stick_id"
    t.integer  "usage"
    t.integer  "avg_distance"
    t.integer  "stick_progres"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "penalties"
  end

  create_table "announcements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "golf_club_id"
    t.text     "body"
    t.string   "header"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
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

  create_table "failed_strokes", :force => true do |t|
    t.integer  "statistic_id"
    t.integer  "user_id"
    t.integer  "stick_id"
    t.integer  "top_strokes"
    t.integer  "short_strokes"
    t.integer  "long_strokes"
    t.integer  "left_strokes"
    t.integer  "more_left_strokes"
    t.integer  "right_strokes"
    t.integer  "more_right_strokes"
    t.integer  "under_strokes"
    t.integer  "ok_strokes"
    t.integer  "total_strokes"
    t.integer  "penalty_strokes"
    t.string   "position_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fields", :force => true do |t|
    t.integer  "golf_club_id"
    t.string   "name",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "very_short_distance"
    t.string   "short_distance"
    t.string   "normal_distance"
    t.string   "long_distance"
    t.string   "short_name"
  end

  create_table "game_filter_statistics", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "field_id"
    t.integer  "hit_sum"
    t.integer  "avg_r_distance"
    t.integer  "avg_p_distance"
    t.integer  "hit_progress"
    t.boolean  "place_teebox",                       :default => false
    t.boolean  "place_feairway",                     :default => false
    t.boolean  "place_next_fairway",                 :default => false
    t.boolean  "place_semi_raf",                     :default => false
    t.boolean  "place_raf",                          :default => false
    t.boolean  "place_for_green",                    :default => false
    t.boolean  "place_green",                        :default => false
    t.boolean  "place_fairway_sand",                 :default => false
    t.boolean  "place_green_sand",                   :default => false
    t.boolean  "place_wood",                         :default => false
    t.boolean  "place_from_water",                   :default => false
    t.boolean  "stance_normal",                      :default => false
    t.boolean  "stance_right_leg_lower",             :default => false
    t.boolean  "stance_left_leg_lower",              :default => false
    t.boolean  "stance_ball_lower",                  :default => false
    t.boolean  "stance_ball_higher",                 :default => false
    t.boolean  "temperature_cold",                   :default => false
    t.boolean  "temperature_normal",                 :default => false
    t.boolean  "temperature_hot",                    :default => false
    t.boolean  "weather_normal",                     :default => false
    t.boolean  "weather_wind",                       :default => false
    t.boolean  "weather_rain",                       :default => false
    t.boolean  "weather_wind_and_rain",              :default => false
    t.boolean  "trajectory_normal",                  :default => false
    t.boolean  "trajectory_high",                    :default => false
    t.boolean  "trajectory_low",                     :default => false
    t.boolean  "wind_from_behind",                   :default => false
    t.boolean  "wind_from_front",                    :default => false
    t.boolean  "wind_from_left",                     :default => false
    t.boolean  "wind_from_right",                    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "trajectory_fade"
    t.boolean  "trajectory_drow"
    t.boolean  "trajectory_slice"
    t.boolean  "trajectory_hook"
    t.boolean  "green_trajectory_straight"
    t.boolean  "green_trajectory_downward_straight"
    t.boolean  "green_trajectory_upward_straight"
    t.boolean  "green_trajectory_upward_left"
    t.boolean  "green_trajectory_upward_right"
    t.boolean  "green_trajectory_downward_left"
    t.boolean  "green_trajectory_downward_right"
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
    t.boolean  "complete"
    t.string   "coplayer_name"
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
    t.string   "image_t_file_name"
    t.string   "image_t_content_type"
    t.integer  "image_t_file_size"
    t.datetime "image_t_updated_at"
    t.boolean  "is_t_banner_disabled"
    t.string   "short_name"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trajectory_fade_hint"
    t.string   "trajectory_drow_hint"
    t.string   "trajectory_slice_hint"
    t.string   "trajectory_hook_hint"
    t.string   "green_direction_upward_straight_hint"
    t.string   "green_direction_downward_straight_hint"
    t.string   "green_direction_upward_left_hint"
    t.string   "green_direction_downward_left_hint"
    t.string   "green_direction_downward_right_hint"
    t.string   "green_direction_upward_right_hint"
    t.string   "green_trajectory_upward_straight_hint"
    t.string   "green_trajectory_downward_right_hint"
    t.string   "green_trajectory_downward_left_hint"
    t.string   "green_trajectory_upward_right_hint"
    t.string   "green_trajectory_upward_left_hint"
    t.string   "green_trajectory_downward_straight_hint"
    t.string   "green_trajectory_straight_hint"
  end

  create_table "hit_places", :force => true do |t|
    t.integer  "field_id"
    t.integer  "place"
    t.string   "name"
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
    t.float    "distance_to_hole"
    t.float    "hit_distance"
  end

  create_table "holes", :force => true do |t|
    t.integer  "field_id"
    t.integer  "par",                 :null => false
    t.integer  "hcp",                 :null => false
    t.integer  "hole_number",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "distance"
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

  create_table "side_ads", :force => true do |t|
    t.integer  "golf_club_id"
    t.string   "header"
    t.string   "body"
    t.string   "link"
    t.boolean  "to_be_shown"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "single_field_statistic_by_sticks", :force => true do |t|
    t.integer  "single_field_statistic_id"
    t.integer  "field_id"
    t.integer  "users_stick_id"
    t.integer  "total_distance"
    t.integer  "total_strokes"
    t.decimal  "avg_distance",              :precision => 6, :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "single_field_statistics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank"
    t.integer  "best_score_hole_1"
    t.integer  "best_score_hole_2"
    t.integer  "best_score_hole_3"
    t.integer  "best_score_hole_4"
    t.integer  "best_score_hole_5"
    t.integer  "best_score_hole_6"
    t.integer  "best_score_hole_7"
    t.integer  "best_score_hole_8"
    t.integer  "best_score_hole_9"
    t.integer  "best_score_hole_10"
    t.integer  "best_score_hole_11"
    t.integer  "best_score_hole_12"
    t.integer  "best_score_hole_13"
    t.integer  "best_score_hole_14"
    t.integer  "best_score_hole_15"
    t.integer  "best_score_hole_16"
    t.integer  "best_score_hole_17"
    t.integer  "best_score_hole_18"
    t.integer  "best_total_score"
    t.string   "best_game_hole_1"
    t.string   "best_game_hole_2"
    t.string   "best_game_hole_3"
    t.string   "best_game_hole_4"
    t.string   "best_game_hole_5"
    t.string   "best_game_hole_6"
    t.string   "best_game_hole_7"
    t.string   "best_game_hole_8"
    t.string   "best_game_hole_9"
    t.string   "best_game_hole_10"
    t.string   "best_game_hole_11"
    t.string   "best_game_hole_12"
    t.string   "best_game_hole_13"
    t.string   "best_game_hole_14"
    t.string   "best_game_hole_15"
    t.string   "best_game_hole_16"
    t.string   "best_game_hole_17"
    t.string   "best_game_hole_18"
  end

  create_table "single_field_statistics_by_holes", :force => true do |t|
    t.integer  "single_field_statistic_id"
    t.integer  "field_id"
    t.integer  "hole_number"
    t.integer  "total_strokes"
    t.integer  "total_putts"
    t.integer  "best_strokes"
    t.integer  "best_putts"
    t.integer  "worst_strokes"
    t.integer  "worst_putts"
    t.decimal  "avg_strokes",               :precision => 6, :scale => 3
    t.decimal  "avg_putts",                 :precision => 6, :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank"
    t.string   "best_game"
  end

  create_table "standard_statistics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "total_stroke_count"
    t.integer  "total_putt_count"
    t.integer  "total_game_count"
    t.integer  "total_hole_count"
    t.integer  "total_stableford"
    t.integer  "total_gir_putts"
    t.integer  "pars"
    t.integer  "boogies"
    t.integer  "eagles"
    t.integer  "birdies"
    t.integer  "double_boogies"
    t.integer  "others"
    t.integer  "total_gir"
    t.decimal  "sbf_avg_per_hole",   :precision => 6, :scale => 3
    t.decimal  "sbf_avg_per_game",   :precision => 6, :scale => 3
    t.decimal  "avg_putts",          :precision => 6, :scale => 3
    t.decimal  "gir_percentage",     :precision => 6, :scale => 3
    t.decimal  "gir_putt_ratio",     :precision => 6, :scale => 3
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trajectory_fade"
    t.integer  "trajectory_drow"
    t.integer  "trajectory_slice"
    t.integer  "trajectory_hook"
    t.integer  "green_direction_downward_straight"
    t.integer  "green_direction_upward_straight"
    t.integer  "green_direction_upward_left"
    t.integer  "green_direction_downward_left"
    t.integer  "green_direction_downward_right"
    t.integer  "green_direction_upward_right"
    t.integer  "green_trajectory_upward_straight"
    t.integer  "green_trajectory_downward_right"
    t.integer  "green_trajectory_downward_left"
    t.integer  "green_trajectory_upward_right"
    t.integer  "green_trajectory_upward_left"
    t.integer  "green_trajectory_downward_straight"
    t.integer  "green_trajectory_straight"
    t.boolean  "calculated"
  end

  create_table "status_holes", :force => true do |t|
    t.integer  "game_id"
    t.integer  "hole_number"
    t.integer  "completeness"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "putts_count"
    t.integer  "total_strokes_count"
  end

  create_table "sticks", :force => true do |t|
    t.string   "stick_type",     :null => false
    t.string   "shaft",          :null => false
    t.string   "shaft_strength", :null => false
    t.string   "short_name",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "distance"
    t.integer  "degrees"
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
    t.string   "perishable_token",   :default => "",    :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

  create_table "users_sticks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stick_id"
    t.integer  "pair_hit_id"
    t.string   "shaft",          :null => false
    t.string   "shaft_strength", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "distance"
    t.integer  "degrees"
    t.boolean  "is_in_bag"
  end

end
