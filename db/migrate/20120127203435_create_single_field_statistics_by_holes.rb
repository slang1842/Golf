class CreateSingleFieldStatisticsByHoles < ActiveRecord::Migration
  def self.up
    create_table :single_field_statistics_by_holes do |t|
			t.references :single_field_statistic
			t.references :field
			t.integer :hole_number
			t.integer :total_strokes
			t.integer :total_putts
			t.integer :best_strokes
			t.integer :best_putts
			t.integer :worst_strokes
			t.integer :worst_putts
			t.decimal :avg_strokes, :precision => 6, :scale => 3
			t.decimal :avg_putts, :precision => 6, :scale => 3
      t.timestamps
    end
  end

  def self.down
    drop_table :single_field_statistics_by_holes
  end
end
