class CreateSingleFieldStatisticBySticks < ActiveRecord::Migration
  def self.up
    create_table :single_field_statistic_by_sticks do |t|
			t.references :single_field_statistic
			t.references :field_id
			t.references :users_stick
			t.integer :total_distance
			t.integer :total_strokes
			t.decimal :avg_distance, :precision => 6, :scale => 3
      t.timestamps
    end
  end

  def self.down
    drop_table :single_field_statistic_by_sticks
  end
end
