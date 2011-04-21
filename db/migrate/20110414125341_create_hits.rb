class CreateHits < ActiveRecord::Migration
  def self.up
    create_table :hits do |t|
      t.references :game
      t.references :user
      t.references :hole
      t.references :stick 
      t.references :users_stick
      t.string :stick_type
      t.string :real_hit # r = real, p = planed, rp = real pair, pp = planed pair
      t.integer :hole_number
      #t.integer :user_stick_id
      #t.integer :hits
      t.integer :hit_number  #
      t.integer :place_from
      t.integer :land_place
      t.string :stance
      t.string :trajectory
      t.string :put_or_hit
      t.boolean :luck_factor
      t.string :comment
      t.integer :following_action
      t.integer :distance_to_hole
      t.integer :hit_distance
      t.integer :wind # from_back, from_front, from_left, from_right
      t.string :hit_was # under, miss, normal, top
      t.string :motion_was # under, miss, normal, top
      t.string :direction
      t.string :misdirection
      t.integer :pair_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :hits
  end
end
