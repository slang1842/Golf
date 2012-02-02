class AddColumnToUsersSticks < ActiveRecord::Migration
  def self.up
		add_column :users_sticks, :is_in_bag, :boolean
  end

  def self.down
  end
end
