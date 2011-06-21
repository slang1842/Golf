class CreateGameStatisticsByHoles < ActiveRecord::Migration
  def self.up
    create_table :game_statistics_by_holes do |t|
      t.references   :user
      t.references   :game
      t.references   :field
      t.references   :hole
      
      t.integer      :hit_sum
      t.integer      :gir_sum
      t.integer      :put_sum
      
      t.integer      :hole_number
      
      t.integer      :hit_p
      t.integer      :hit_r
      t.integer      :puts_p
      t.integer      :puts_r
      t.string       :stick_order_p
      t.string       :stick_order_r
      t.timestamps
    end
  end

  def self.down
    drop_table :game_statistics_by_balls
  end
end
