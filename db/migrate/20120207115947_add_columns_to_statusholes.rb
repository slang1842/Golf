class AddColumnsToStatusholes < ActiveRecord::Migration
  def self.up
		add_column :status_holes, :putts_count, :integer
		add_column :status_holes, :total_strokes_count, :integer
  end

  def self.down
  end
end
