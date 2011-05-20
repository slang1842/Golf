class CreateGameStatisticsBySticks < ActiveRecord::Migration
  def self.up
    create_table :game_statistics_by_sticks do |t|
      t.references   :games
      t.references   :fields
      t.references   :sticks
      
      t.integer      :hit_sum
      t.integer      :gir_sum
      t.integer      :puts_sum
      t.integer      :hits_p
      t.integer      :hits_r
      t.integer      :avg_distance
      t.integer      :stick_usage
      t.timestamps
    end
  end

  def self.down
    drop_table :game_statistics_by_sticks
  end
end
