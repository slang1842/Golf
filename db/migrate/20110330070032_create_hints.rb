class CreateHints < ActiveRecord::Migration
  def self.up
    create_table :hints do |t|
      t.references :user
      t.references :stick
      
      t.string :place_teebox_hint
      t.string :place_feairway_hint
      t.string :place_next_fairway_hint
      t.string :place_semi_raf_hint
      t.string :place_raf_hint
      t.string :place_for_green_hint
      t.string :place_green_hint
      t.string :place_fairway_sand_hint
      t.string :place_green_sand_hint
      t.string :place_wood_hint
      t.string :place_from_water_hint

      t.string :stance_normal_hint
      t.string :stance_right_leg_lower_hint
      t.string :stance_left_leg_lower_hint
      t.string :stance_ball_lower_hint
      t.string :stance_ball_higher_hint

      t.string :direction_straigth_hint
      t.string :direction_fade_hint
      t.string :direction_drow_hint
      t.string :direction_slice_hint
      t.string :direction_hook_hint

      t.string :temperature_cold_hint
      t.string :temperature_normal_hint
      t.string :temperature_hot_hint

      t.string :weather_normal_hint
      t.string :weather_wind_hint
      t.string :weather_rain_hint
      t.string :weather_wind_and_rain_hint

      t.string :trajectory_normal_hint
      t.string :trajectory_high_hint
      t.string :trajectory_low_hint

      t.string :wind_from_behind_hint
      t.string :wind_from_front_hint
      t.string :wind_from_left_hint
      t.string :wind_from_right_hint

      t.integer     :green_strength_light_hint
      t.integer     :green_strength_normal_hint
      t.integer     :green_strength_strong_hint
      t.integer     :green_strength_very_strong_hint

      t.integer     :green_direction_straight_hint
      t.integer     :green_direction_to_right_hint
      t.integer     :green_direction_to_left_hint
      t.integer     :green_direction_more_to_right_hint
      t.integer     :green_direction_more_to_left_hint

      t.integer     :green_tilt_straight_hint
      t.integer     :green_tilt_upward_hint
      t.integer     :green_tilt_downward_hint
      t.integer     :green_tilt_very_upward_hint
      t.integer     :green_tilt_very_downward_hint

      t.timestamps
    end
  end

  def self.down
    drop_table :hints
  end
end
