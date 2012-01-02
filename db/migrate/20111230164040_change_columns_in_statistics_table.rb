class ChangeColumnsInStatisticsTable < ActiveRecord::Migration
  def self.up
			remove_column :statistics,  :direction_straigth
			remove_column :statistics, :direction_fade
			remove_column :statistics,	:direction_drow
			remove_column :statistics,	:direction_slice
			remove_column :statistics,	:direction_hook
			remove_column :statistics,	:green_tilt_straight
			remove_column :statistics,	:green_tilt_downward
			remove_column :statistics,	:green_tilt_upward
			remove_column :statistics, :green_tilt_very_downward
			remove_column :statistics, :green_tilt_very_upward
		
			add_column :statistics, :trajectory_fade, :integer
			add_column :statistics, :trajectory_drow, :integer
			add_column :statistics, :trajectory_slice, :integer
			add_column :statistics, :trajectory_hook, :integer
			add_column :statistics, :green_direction_downward, :integer
			add_column :statistics, :green_direction_upward, :integer
			add_column :statistics, :green_direction_very_upward, :integer
			add_column :statistics, :green_direction_very_downward, :integer
  end

  def self.down
			add_column :statistics, :direction_straigth, :integer
			add_column :statistics, :direction_fade, :integer
			add_column :statistics,	:direction_drow, :integer
			add_column :statistics,	:direction_slice, :integer
			add_column :statistics,	:direction_hook, :integer
			add_column :statistics,	:green_tilt_straight, :integer
			add_column :statistics,	:green_tilt_downward, :integer
			add_column :statistics,	:green_tilt_upward, :integer
			add_column :statistics, :green_tilt_very_downward, :integer
			add_column :statistics, :green_tilt_very_upward, :integer

			remove_column :statistics, :trajectory_fade
			remove_column :statistics, :trajectory_drow
			remove_column :statistics, :trajectory_slice
			remove_column :statistics, :trajectory_hook
			remove_column :statistics, :green_slope_downward
			remove_column :statistics, :green_slope_upward
			remove_column :statistics, :green_slope_very_upward
			remove_column :statistics, :green_slope_very_downward
  end
end
