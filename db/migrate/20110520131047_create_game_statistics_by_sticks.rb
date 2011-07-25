class CreateGameStatisticsBySticks < ActiveRecord::Migration
  def self.up
    create_table :game_statistics_by_sticks do |t|
      t.references   :game
      t.references   :fields
      t.references   :users_stick
      t.references   :user
      
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
