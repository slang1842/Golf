class CreateFields < ActiveRecord::Migration
  def self.up
    create_table :fields do |t|
      t.references :golf_club
      t.string     :name,        :null => false
			#t.string		 :short_name
      t.integer :very_short_distance
      t.integer :short_distance
      t.integer :normal_distance
      t.integer :long_distance
      t.timestamps
    end
  end

  def self.down
    drop_table :fields
  end
end
