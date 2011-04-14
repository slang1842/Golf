class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :field_quality
      t.string :temperature
      t.string :weather
      t.time :date
      t.string :game_format
      t.references :user
      t.references :field
      t.string :game_type
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
