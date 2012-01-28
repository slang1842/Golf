class AddCompleteToGame < ActiveRecord::Migration
  def self.up
		add_column :games, :complete, :boolean
  end

  def self.down
  end
end
