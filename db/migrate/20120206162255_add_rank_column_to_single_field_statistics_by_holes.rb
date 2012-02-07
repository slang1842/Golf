class AddRankColumnToSingleFieldStatisticsByHoles < ActiveRecord::Migration
  def self.up
		add_column :single_field_statistics_by_holes, :rank, :integer
  end

  def self.down
  end
end
