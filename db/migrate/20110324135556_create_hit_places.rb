class CreateHitPlaces < ActiveRecord::Migration
  def self.up
    create_table :hit_places do |t|
      t.references :field
      # t.integer :place,      :null => false
      # t.integer :color,      :null => false
      # t.integer :very_short_distance, :null => false
      # t.integer :short_distance, :null => false
      # t.integer :normal_distance, :null => false
      # t.integer :long_distance, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :hit_places
  end
end
