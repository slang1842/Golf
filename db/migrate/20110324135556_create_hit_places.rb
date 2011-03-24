class CreateHitPlaces < ActiveRecord::Migration
  def self.up
    create_table :hit_places do |t|
      t.references :field
      t.integer :place
      t.integer :color

      t.timestamps
    end
  end

  def self.down
    drop_table :hit_places
  end
end
