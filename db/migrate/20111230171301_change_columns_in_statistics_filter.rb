class ChangeColumnsInStatisticsFilter < ActiveRecord::Migration
  def self.up
		remove_column :game_filter_statistics,	:direction_straigth
    remove_column :game_filter_statistics,	:direction_fade
    remove_column :game_filter_statistics,	:direction_drow
    remove_column :game_filter_statistics,  :direction_slice
    remove_column :game_filter_statistics,	:direction_hook

		add_column :game_filter_statistics, :trajectory_fade, :boolean
		add_column :game_filter_statistics, :trajectory_drow, :boolean
		add_column :game_filter_statistics, :trajectory_slice, :boolean
		add_column :game_filter_statistics, :trajectory_hook, :boolean
  end

  def self.down
		add_column :game_filter_statistics,	:direction_straigth, :boolean
    add_column :game_filter_statistics,	:direction_fade, :boolean
    add_column :game_filter_statistics,	:direction_drow, :boolean
    add_column :game_filter_statistics,  :direction_slice, :boolean
    add_column :game_filter_statistics,	:direction_hook, :boolean

		remove_column :game_filter_statistics, :trajectory_fade
		remove_column :game_filter_statistics, :trajectory_drow
		remove_column :game_filter_statistics, :trajectory_slice
		remove_column :game_filter_statistics, :trajectory_hook
  end
end
