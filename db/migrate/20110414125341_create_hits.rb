class CreateHits < ActiveRecord::Migration
  def self.up
    create_table :hits do |t|
      t.references :game
      t.references :user
      t.references :hole
      t.references :user_stick
      t.boolean :real_hit
      t.integer :hits
      t.integer :puts
      t.string :follow_up
      t.string :stance
      t.integer :hardness
      t.string :motion
      t.string :hit_type
      t.string :luck_factor
      t.string :comment
      t.integer :distance_to_hole_land
      t.integer :distance_to_hole_hit
      t.integer :distance_to_hole_left
      t.integer :hole_count
      t.timestamps
    end
  end

  def self.down
    drop_table :hits
  end
end
