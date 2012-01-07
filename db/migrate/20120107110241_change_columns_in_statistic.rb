class ChangeColumnsInStatistic < ActiveRecord::Migration
  def self.up
				rename_column :statistics, :green_direction_downward, :green_direction_downward_straight
			rename_column :statistics, :green_direction_upward, :green_direction_upward_straight
			rename_column :statistics, :green_direction_very_upward, :green_direction_upward_left
			rename_column :statistics, :green_direction_very_downward, :green_direction_downward_left
			add_column :statistics, :green_direction_downward_right, :integer
			add_column :statistics, :green_direction_upward_right, :integer
			add_column :statistics, :green_trajectory_upward_straight, :integer
			add_column :statistics, :green_trajectory_downward_right, :integer
			add_column :statistics, :green_trajectory_downward_left, :integer
			add_column :statistics, :green_trajectory_upward_right, :integer		
			add_column :statistics, :green_trajectory_upward_left, :integer
			add_column :statistics, :green_trajectory_downward_straight, :integer
			add_column :statistics, :green_trajectory_straight, :integer

			rename_column :hints,	:green_direction_upward_hint, :green_direction_upward_straight_hint
    	rename_column :hints,	:green_direction_downward_hint, :green_direction_downward_straight_hint
  	  rename_column :hints,	:green_direction_very_upward_hint, :green_direction_upward_left_hint
  	  rename_column :hints,	:green_direction_very_downward_hint, :green_direction_downward_left_hint
			
			add_column :hints, :green_direction_downward_right_hint, :string
			add_column :hints, :green_direction_upward_right_hint, :string
			add_column :hints, :green_trajectory_upward_straight_hint, :string
			add_column :hints, :green_trajectory_downward_right_hint, :string
			add_column :hints, :green_trajectory_downward_left_hint, :string
			add_column :hints, :green_trajectory_upward_right_hint, :string
			add_column :hints, :green_trajectory_upward_left_hint, :string
			add_column :hints, :green_trajectory_downward_straight_hint, :string
			add_column :hints, :green_trajectory_straight_hint, :string

			add_column :game_filter_statistics, :green_trajectory_straight, :boolean
			add_column :game_filter_statistics, :green_trajectory_downward_straight, :boolean
			add_column :game_filter_statistics, :green_trajectory_upward_straight, :boolean
			add_column :game_filter_statistics, :green_trajectory_upward_left, :boolean
			add_column :game_filter_statistics, :green_trajectory_upward_right, :boolean
			add_column :game_filter_statistics, :green_trajectory_downward_left, :boolean
			add_column :game_filter_statistics, :green_trajectory_downward_right, :boolean

  end

  def self.down
			rename_column :statistics, :green_direction_downward_straight, :green_direction_downward
			rename_column :statistics, :green_direction_upward_straight, :green_direction_upward
			rename_column :statistics, :green_direction_upward_left, :green_direction_very_upward
			rename_column :statistics, :green_direction_downward_left, :green_direction_very_downward
			remove_column :statistics, :green_direction_downward_right
			remove_column :statistics, :green_direction_upward_right
			remove_column :statistics, :green_trajectory_upward_straight
			remove_column :statistics, :green_trajectory_downward_right
			remove_column :statistics, :green_trajectory_downward_left
			remove_column :statistics, :green_trajectory_upward_right
			remove_column :statistics, :green_trajectory_upward_left
			remove_column :statistics, :green_trajectory_downward_straight
			remove_column :statistics, :green_trajectory_straight

			rename_column :hints, :green_direction_upward_straight_hint, :green_direction_upward_hint
    	rename_column :hints, :green_direction_downward_straight_hint, :green_direction_downward_hint
  	  rename_column :hints, :green_direction_upward_left_hint, :green_direction_very_upward_hint
  	  rename_column :hints, :green_direction_downward_left_hint, :green_direction_very_downward_hint
			
			remove_column :hints, :green_direction_downward_right_hint
			remove_column :hints, :green_direction_upward_right_hint
			remove_column :hints, :green_trajectory_upward_straight_hint
			remove_column :hints, :green_trajectory_downward_right_hint
			remove_column :hints, :green_trajectory_downward_left_hint
			remove_column :hints, :green_trajectory_upward_right_hint
			remove_column :hints, :green_trajectory_upward_left_hint
			remove_column :hints, :green_trajectory_downward_straight_hint
			remove_column :hints, :green_trajectory_straight_hint

			remove_column :game_filter_statistics, :green_trajectory_straight
			remove_column :game_filter_statistics, :green_trajectory_downward_straight
			remove_column :game_filter_statistics, :green_trajectory_upward_straight
			remove_column :game_filter_statistics, :green_trajectory_upward_left
			remove_column :game_filter_statistics, :green_trajectory_upward_right
			remove_column :game_filter_statistics, :green_trajectory_downward_left
			remove_column :game_filter_statistics, :green_trajectory_downward_right
			
  end
end
