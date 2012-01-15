class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
	
			t.references :user
			t.references :golf_club
	
 			t.string :body
			t.string :header
			
			t.string      :image_file_name
      t.string      :image_content_type
      t.integer     :image_file_size
      t.datetime    :image_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end
