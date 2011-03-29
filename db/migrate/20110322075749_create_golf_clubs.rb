class CreateGolfClubs < ActiveRecord::Migration
  def self.up
    create_table :golf_clubs do |t|
      t.references   :user#,                        :null => false
      t.string       :name,                        :null => false
      t.references   :countries#,                     :null => false
      t.string 		   :region,                      :null => false
      t.string		   :city,                        :null => false
      t.string 		   :web_page,                    :null => false
      t.string		   :start_place_by_level_low
      t.string 		   :start_place_by_level_medium
      t.string		   :start_place_by_level_high
      t.boolean      :accepted,                    :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :golf_clubs
  end
end
