class AddGameDatesToSingleFieldStats < ActiveRecord::Migration
  def self.up
		add_column :single_field_statistics, :best_game_hole_1, :string
		add_column :single_field_statistics, :best_game_hole_2, :string
		add_column :single_field_statistics, :best_game_hole_3, :string
		add_column :single_field_statistics, :best_game_hole_4, :string
		add_column :single_field_statistics, :best_game_hole_5, :string
		add_column :single_field_statistics, :best_game_hole_6, :string
		add_column :single_field_statistics, :best_game_hole_7, :string
		add_column :single_field_statistics, :best_game_hole_8, :string
		add_column :single_field_statistics, :best_game_hole_9, :string
		add_column :single_field_statistics, :best_game_hole_10, :string
		add_column :single_field_statistics, :best_game_hole_11, :string
		add_column :single_field_statistics, :best_game_hole_12, :string
		add_column :single_field_statistics, :best_game_hole_13, :string
		add_column :single_field_statistics, :best_game_hole_14, :string
		add_column :single_field_statistics, :best_game_hole_15, :string
		add_column :single_field_statistics, :best_game_hole_16, :string
		add_column :single_field_statistics, :best_game_hole_17, :string
		add_column :single_field_statistics, :best_game_hole_18, :string
  end

  def self.down
  end
end
