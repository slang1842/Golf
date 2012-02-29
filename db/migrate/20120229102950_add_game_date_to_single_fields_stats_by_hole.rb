class AddGameDateToSingleFieldsStatsByHole < ActiveRecord::Migration
  def self.up
		add_column :single_field_statistics_by_holes, :best_game, :string
  end

  def self.down
  end
end
