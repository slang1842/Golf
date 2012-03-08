class AddNameColumnToGame < ActiveRecord::Migration
  def self.up
		add_column :games, :coplayer_name, :string
  end

  def self.down
  end
end
