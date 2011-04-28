class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
       t.references :user
       t.references :stick
       
       # N = in all statistic meens No Value
       
       t.string     :place_teebox
       t.string     :place_feairway
       t.string     :place_next_fairway
       t.string     :place_semi_raf
       t.string     :place_raf
       t.string     :place_for_green
       t.string     :place_green
       t.string     :place_fairway_sand
       t.string     :place_green_sand
       t.string     :place_wood
       t.string     :place_from_water
       
       t.string     :stance_normal
       t.string     :stance_right_leg_lower
       t.string     :stance_left_leg_lower
       t.string     :stance_ball_lower
       t.string     :stance_ball_higher
       
       t.string     :direction_straigth
       t.string     :direction_fade
       t.string     :direction_drow
       t.string     :direction_slice
       t.string     :direction_hook
       
       t.string     :temperature_cold
       t.string     :temperature_normal
       t.string     :temperature_hot
       
       t.string     :weather_normal
       t.string     :weather_wind
       t.string     :weather_rain
       t.string     :weather_rain_and_wind
       
       t.string     :trajectory_normal
       t.string     :trajectory_high
       t.string     :trajectory_low
       
      t.timestamps
    end
  end

  def self.down
    drop_table :statistics
  end
end
