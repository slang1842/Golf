class CreateGolfClubs < ActiveRecord::Migration
  def self.up
    create_table :golf_clubs do |t|
      t.integer :club_owner
      t.string  :club_name
      t.string  :country
      t.string  :region
      t.string  :green_fee
      t.string  :city
      t.string  :web_page
      t.string :start_place_by_level_low
      t.integer :start_place_by_level_medium
      t.integer :start_place_by_level_high
    end
  end

  def self.down
   drop_table :golf_clubs
  end
end
