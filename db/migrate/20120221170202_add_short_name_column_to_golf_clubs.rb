class AddShortNameColumnToGolfClubs < ActiveRecord::Migration
  def self.up
		add_column :golf_clubs, :short_name, :string
		add_column :fields, :short_name, :string
  end

  def self.down
  end
end
