class CreateGameStatisticGenerals < ActiveRecord::Migration
  def self.up
    create_table :game_statistic_generals do |t|
      t.references :game
      t.integer    :hit_sum
      t.integer   :put_sum
      t.integer    :gir_sum
      t.timestamps
    end
  end

  def self.down
    drop_table :game_statistic_generals
  end
end
