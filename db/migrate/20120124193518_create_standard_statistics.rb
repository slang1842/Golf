class CreateStandardStatistics < ActiveRecord::Migration
  def self.up
    create_table :standard_statistics do |t|
			t.references :user
			t.integer :total_stroke_count
			t.integer :total_putt_count
			t.integer :total_game_count
			t.integer :total_hole_count
			t.integer :total_stableford
			t.integer :total_gir_putts
			t.integer :pars
			t.integer :boogies
			t.integer :eagles
			t.integer :birdies
			t.integer :double_boogies
			t.integer :others
			t.integer :total_gir
			t.decimal :sbf_avg_per_hole, :precision => 6, :scale => 3
			t.decimal :sbf_avg_per_game, :precision => 6, :scale => 3
			t.decimal :avg_putts, :precision => 6, :scale => 3
			t.decimal :gir_percentage, :precision => 6, :scale => 3
			t.decimal :gir_putt_ratio, :precision => 6, :scale => 3
      t.timestamps
    end
  end

  def self.down
    drop_table :standard_statistics
  end
end
