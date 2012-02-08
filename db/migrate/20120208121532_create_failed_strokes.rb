class CreateFailedStrokes < ActiveRecord::Migration
  def self.up
    create_table :failed_strokes do |t|
			t.references :statistic
			t.references :user
			t.references :stick
			t.integer :top_strokes
			t.integer :short_strokes
			t.integer :long_strokes
			t.integer :left_strokes
			t.integer :more_left_strokes
			t.integer :right_strokes
			t.integer :more_right_strokes
			t.integer :under_strokes
			t.integer :ok_strokes
			t.integer :total_strokes
			t.integer :penalty_strokes
			t.string	:position_name
      t.timestamps
    end
  end

  def self.down
    drop_table :failed_strokes
  end
end
