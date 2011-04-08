class CreateUsersSticks < ActiveRecord::Migration
  def self.up
    create_table :users_sticks do |t|
      t.references  :user
      t.references  :Stick
      t.string      :distance
      t.string      :degrees
      t.string      :shaft
      t.string      :shaft_strength
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users_sticks
  end
end
