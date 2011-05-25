class CreateGolfClubs < ActiveRecord::Migration
  def self.up
    create_table :golf_clubs do |t|
      t.references   :user
      t.string       :name,                        :null => false
      t.references   :country                     #:null => false
      t.string 		   :region,                      :null => false
      t.string		   :city,                        :null => false
      t.string 		   :web_page,                    :null => false
      t.string		   :start_place_by_level_low
      t.string 		   :start_place_by_level_medium
      t.string		   :start_place_by_level_high
      t.string       :accepted,                    :default => "unknown" # unknown, no, yes
      t.boolean      :active,                      :default => false

      #image
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :golf_clubs
  end
end
