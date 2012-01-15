class ChangeFormStringToText < ActiveRecord::Migration
  def self.up
		change_column :announcements, :body, :text
  end

  def self.down
  end
end
