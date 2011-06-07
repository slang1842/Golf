class CreateGameFilterStatistics < ActiveRecord::Migration
  def self.up
    create_table :game_filter_statistics do |t|
      t.references     :game
      t.references     :user
      t.references     :field

      t.integer        :hit_sum
      t.integer        :avg_r_distance
      t.integer        :avg_p_distance
      t.integer        :hit_progress

      t.boolean                   :place_teebox,            :default => false
      t.boolean                   :place_feairway,            :default => false
      t.boolean                   :place_next_fairway,            :default => false
      t.boolean                   :place_semi_raf,            :default => false
      t.boolean                   :place_raf,            :default => false
      t.boolean                   :place_for_green,            :default => false
      t.boolean                   :place_green,            :default => false
      t.boolean                   :place_fairway_sand,            :default => false
      t.boolean                   :place_green_sand,            :default => false
      t.boolean                   :place_wood,            :default => false
      t.boolean                   :place_from_water,            :default => false

      t.boolean                   :stance_normal,            :default => false
      t.boolean                   :stance_right_leg_lower,            :default => false
      t.boolean                   :stance_left_leg_lower,            :default => false
      t.boolean                   :stance_ball_lower,            :default => false
      t.boolean                   :stance_ball_higher,            :default => false

      t.boolean                   :direction_straigth,            :default => false
      t.boolean                   :direction_fade,            :default => false
      t.boolean                   :direction_drow,            :default => false
      t.boolean                   :direction_slice,            :default => false
      t.boolean                   :direction_hook,            :default => false

      t.boolean                   :temperature_cold,            :default => false
      t.boolean                   :temperature_normal,            :default => false
      t.boolean                   :temperature_hot,            :default => false

      t.boolean                   :weather_normal,            :default => false
      t.boolean                   :weather_wind,            :default => false
      t.boolean                   :weather_rain,            :default => false
      t.boolean                   :weather_wind_and_rain,            :default => false

      t.boolean                   :trajectory_normal,            :default => false
      t.boolean                   :trajectory_high,              :default => false
      t.boolean                   :trajectory_low,               :default => false

      t.boolean                   :wind_from_behind,            :default => false
      t.boolean                   :wind_from_front,            :default => false
      t.boolean                   :wind_from_left,            :default => false
      t.boolean                   :wind_from_right,            :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :game_filter_statistics
  end
end
