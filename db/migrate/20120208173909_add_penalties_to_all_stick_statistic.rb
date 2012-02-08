class AddPenaltiesToAllStickStatistic < ActiveRecord::Migration
  def self.up
	add_column :all_stick_statistics, :penalties, :integer
  end

  def self.down
  end
end
