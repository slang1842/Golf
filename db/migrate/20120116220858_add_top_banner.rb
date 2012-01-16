class AddTopBanner < ActiveRecord::Migration
  def self.up
		add_column :golf_clubs, :image_t_file_name, :string
		add_column :golf_clubs, :image_t_content_type, :string
		add_column :golf_clubs, :image_t_file_size, :integer
		add_column :golf_clubs, :image_t_updated_at, :datetime
		add_column :golf_clubs, :is_t_banner_disabled, :boolean
  end

  def self.down
		remove_column :golf_clubs, :image_t_file_name
		remove_column :golf_clubs, :image_t_content_type
		remove_column :golf_clubs, :image_t_file_size
		remove_column :golf_clubs, :image_t_updated_at
		remove_column :golf_clubs, :is_t_banner_disabled
	end

end
