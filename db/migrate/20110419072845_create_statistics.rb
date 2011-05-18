class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.references :user
      t.references :stick
       
      # Nil = in all statistic meens No Value
       
      t.string     :place_teebox
      t.references :place_teebox_hint
       
      t.string     :place_feairway
      t.references :place_feairway_hint
       
      t.string     :place_next_fairway
      t.references :place_next_fairway_hint
       
      t.string     :place_semi_raf
      t.references :place_semi_raf_hint
       
      t.string     :place_raf
      t.references :place_raf_hint
      
      t.string     :place_for_green
      t.references :place_for_green_hint
      
      t.string     :place_green
      t.references :place_green_hint
      
      t.string     :place_fairway_sand
      t.references :place_fairway_sand_hint
      
      t.string     :place_green_sand
      t.references :place_green_sand_hint
      
      t.string     :place_wood
      t.references :place_wood_hint
      
      t.string     :place_from_water
      t.references :place_from_water_hint
      
      #==========================
      
      t.string     :stance_normal
      t.references :stance_normal_hint
      
      t.string     :stance_right_leg_lower
      t.references :stance_right_leg_lower_hint
      
      t.string     :stance_left_leg_lower
      t.references :stance_left_leg_lower_hint
      
      t.string     :stance_ball_lower
      t.references :stance_ball_lower_hint
      
      t.string     :stance_ball_higher
      t.references :stance_ball_higher_hint
       
      #==========================
      
      t.string     :direction_straigth
      t.references :direction_straigth_hint
      
      t.string     :direction_fade
      t.references :direction_fade_hint
      
      t.string     :direction_drow
      t.references :direction_drow_hint
      
      t.string     :direction_slice
      t.references :direction_slice_hint
      
      t.string     :direction_hook
      t.references :direction_hook_hint
        
      #==========================
      
      t.string     :temperature_cold
      t.references :temperature_cold_hint
      
      t.string     :temperature_normal
      t.references :temperature_normal_hint
      
      t.string     :temperature_hot
      t.references :temperature_hot_hint
        
      #==========================
      
      t.string     :weather_normal
      t.references :weather_normal_hint
      
      t.string     :weather_wind
      t.references :weather_wind_hint
      
      t.string     :weather_rain
      t.references :weather_rain_hint
      
      t.string     :weather_wind_and_rain
      t.references :weather_wind_and_rain_hint
      
      #==========================
      
      t.string     :trajectory_normal
      t.references :trajectory_normal_hint
      
      t.string     :trajectory_high
      t.references :trajectory_high_hint
      
      t.string     :trajectory_low
      t.references :trajectory_low_hint
        
      #==========================
      
      t.string     :wind_from_behind #From behind
      t.references :wind_from_behind_hint
      
      t.string     :wind_from_front  #From front
      t.references :wind_from_front_hint
      
      t.string     :wind_from_left   #From left
      t.references :wind_from_left_hint
      
      t.string     :wind_from_right  #From right
      t.references :wind_from_right_hint
      
      t.timestamps
    end
  end

  def self.down
    drop_table :statistics
  end
end
