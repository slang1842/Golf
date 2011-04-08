class CreateBalls < ActiveRecord::Migration
  def self.up
    create_table :balls do |t|
      t.references  :user
      t.string      :ball_manufacturer
      t.string      :ball_type
      
      t.timestamps
    end
  end

  def self.down
    drop_table :balls
  end
end
