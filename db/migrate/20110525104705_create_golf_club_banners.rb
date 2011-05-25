class CreateGolfClubBanners < ActiveRecord::Migration
  def self.up
    create_table :golf_club_banners do |t|
      t.references     :golf_club
      t.date           :date_limit
      t.boolean         :is_pay_banner
            
      #image
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :golf_club_banners
  end
end
