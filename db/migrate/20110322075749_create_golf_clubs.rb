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
      t.datetime     :pay_banner_end_date
      t.boolean      :is_p_banner_disabled,            :default => false
      t.boolean      :is_f_banner_disabled,            :default => false
      t.boolean      :is_v_banner_disabled,            :default => false
      
      #image_v
      t.string :image_v_file_name
      t.string :image_v_content_type
      t.integer :image_v_file_size
      t.datetime :image_v_updated_at
      
      #image_f
      t.string :image_f_file_name
      t.string :image_f_content_type
      t.integer :image_f_file_size
      t.datetime :image_f_updated_at
      
      #image_p
      t.string :image_p_file_name
      t.string :image_p_content_type
      t.integer :image_p_file_size
      t.datetime :image_p_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :golf_clubs
  end
end
