class CreateUsersSticks < ActiveRecord::Migration
  def self.up
    create_table :users_sticks do |t|
      t.references  :user
      t.references  :stick
      t.references  :pair_hit
      t.string      :distance,          :null => false
      t.string      :degrees,           :null => false
      t.string      :shaft,             :null => false
      t.string      :shaft_strength,    :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users_sticks
  end
end
