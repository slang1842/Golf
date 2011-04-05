class CreateSticksUsers < ActiveRecord::Migration
  def self.up
    create_table :sticks_users do |t|
      t.references  :user
      t.references  :stick
      t.string      :attālums
      t.string      :grādi
      t.string      :shaft
      t.string      :shaft_strength
      
      t.timestamps
    end
  end

  def self.down
    drop_table :balls
  end
end
