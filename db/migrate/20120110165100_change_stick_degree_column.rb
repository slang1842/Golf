class ChangeStickDegreeColumn < ActiveRecord::Migration
  def self.up
		remove_column :sticks, :degrees
		remove_column :users_sticks, :degrees
		add_column :sticks, :degrees, :integer
		add_column :users_sticks, :degrees, :integer
  end

  def self.down
		remove_column :sticks, :degrees
		remove_column :users_sticks, :degrees
  end
end
