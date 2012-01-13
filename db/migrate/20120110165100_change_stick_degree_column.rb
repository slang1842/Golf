class ChangeStickDegreeColumn < ActiveRecord::Migration
  def self.up
		change_column :sticks, :degrees, :integer
		change_column :users_sticks, :degrees, :integer
  end

  def self.down
		change_column :sticks, :degrees, :integer, :null => false
		change_column :users_sticks, :degrees, :integer, :null => false
  end
end
