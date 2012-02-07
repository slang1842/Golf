class AddColumnsToSingleFieldStatistics < ActiveRecord::Migration
  def self.up
		add_column :single_field_statistics, :rank, :integer
		add_column :single_field_statistics, :best_score_hole_1, :integer
		add_column :single_field_statistics, :best_score_hole_2, :integer
		add_column :single_field_statistics, :best_score_hole_3, :integer
		add_column :single_field_statistics, :best_score_hole_4, :integer
		add_column :single_field_statistics, :best_score_hole_5, :integer
		add_column :single_field_statistics, :best_score_hole_6, :integer
		add_column :single_field_statistics, :best_score_hole_7, :integer
		add_column :single_field_statistics, :best_score_hole_8, :integer
		add_column :single_field_statistics, :best_score_hole_9, :integer
		add_column :single_field_statistics, :best_score_hole_10, :integer
		add_column :single_field_statistics, :best_score_hole_11, :integer
		add_column :single_field_statistics, :best_score_hole_12, :integer
		add_column :single_field_statistics, :best_score_hole_13, :integer
		add_column :single_field_statistics, :best_score_hole_14, :integer
		add_column :single_field_statistics, :best_score_hole_15, :integer
		add_column :single_field_statistics, :best_score_hole_16, :integer
		add_column :single_field_statistics, :best_score_hole_17, :integer
		add_column :single_field_statistics, :best_score_hole_18, :integer
		add_column :single_field_statistics, :best_total_score, :integer
  end

  def self.down
  end
end
