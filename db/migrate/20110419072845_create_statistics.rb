class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.references :game
      t.references :field
      t.references :user
      t.references :stick
       
      # Nil = in all statistic meens No Value
       
      t.integer     :place_teebox
      t.integer     :place_feairway
      t.integer     :place_next_fairway
      t.integer     :place_semi_raf
      t.integer     :place_raf
      t.integer     :place_for_green
      t.integer     :place_green
      t.integer     :place_fairway_sand
      t.integer     :place_green_sand
      t.integer     :place_wood
      t.integer     :place_from_water
      
      #==========================
      
      t.integer     :stance_normal
      t.integer     :stance_right_leg_lower
      t.integer     :stance_left_leg_lower
      t.integer     :stance_ball_lower
      t.integer     :stance_ball_higher
       
      #==========================
      
      t.integer     :direction_straigth
      t.integer     :direction_fade
      t.integer     :direction_drow
      t.integer     :direction_slice
      t.integer     :direction_hook
        
      #==========================
      
      t.integer     :temperature_cold
      t.integer     :temperature_normal
      t.integer     :temperature_hot
        
      #==========================
      
      t.integer     :weather_normal
      t.integer     :weather_wind
      t.integer     :weather_rain
      t.integer     :weather_wind_and_rain
      
      #==========================
      
      t.integer     :trajectory_normal
      t.integer     :trajectory_high
      t.integer     :trajectory_low
        
      #==========================
      
      t.integer     :wind_from_behind #From behind
      t.integer     :wind_from_front  #From front
      t.integer     :wind_from_left   #From left
      t.integer     :wind_from_right  #From right

      #==========================

      #stiprums (statistika: strength)
      t.integer     :green_strength_light
      t.integer     :green_strength_normal
      t.integer     :green_strength_strong
      t.integer     :green_strength_very_strong

      #==========================

      #Slīpums
      # tas pats kas direction/misdirection (statistika: slope)
      t.integer     :green_direction_straight
      t.integer     :green_direction_to_right
      t.integer     :green_direction_to_left
      t.integer     :green_direction_more_to_right
      t.integer     :green_direction_more_to_left

      #==========================

      #Kritums  (statistika: tilt)
      t.integer     :green_tilt_straight
      t.integer     :green_tilt_upward
      t.integer     :green_tilt_downward
      t.integer     :green_tilt_very_upward
      t.integer     :green_tilt_very_downward

      t.timestamps
    end
  end

  def self.down
    drop_table :statistics
  end
end
