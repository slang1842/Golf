class CreateGames < ActiveRecord::Migration
  def self.up
    create_table   :games do |t|
      t.string     :field_quality
      t.string     :green_quality
      t.integer    :temperature
      t.integer    :weather
      t.datetime       :date
      t.string     :game_format
      t.references :user
      t.references :field
      t.integer    :game_type
      t.integer    :start_place_colors
      t.string     :comment
      t.string     :hit_direction
      t.integer    :next_hole
      t.integer    :active_hit
      t.string     :form
      t.timestamps
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
