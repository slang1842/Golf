class CreateSticks < ActiveRecord::Migration
  def self.up
    create_table :sticks do |t|
      t.string      :stick_type
      t.integer     :distance
      t.integer     :degrees
      t.string      :shaft
      t.string      :shaft_strength
      t.timestamps
    end
  end

  def self.down
    drop_table :sticks
  end
end
