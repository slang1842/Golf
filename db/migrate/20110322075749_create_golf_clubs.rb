class CreateGolfClubs < ActiveRecord::Migration
  def self.up
    create_table :golf_clubs do |t|
      t.references   :user
      t.string       :name
      t.references   :country
      t.string 		 :region
      t.string		 :green_fee
      t.string		 :city
      t.string 		 :web_page
      t.string		 :start_place_by_level_low
      t.string 		 :start_place_by_level_medium
      t.string		 :start_place_by_level_high

      t.timestamps
    end
  end

  def self.down
    drop_table :golf_clubs
  end
end
