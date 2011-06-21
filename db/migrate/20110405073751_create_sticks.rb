class CreateSticks < ActiveRecord::Migration
  def self.up
    create_table :sticks do |t|
      t.string      :stick_type,        :null => false
      t.integer     :distance,          :null => false
      t.integer     :degrees,           :null => false
      t.string      :shaft,             :null => false
      t.string      :shaft_strength,    :null => false
      t.string      :short_name,        :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :sticks
  end
end
