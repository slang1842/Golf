class AddCalculatedFieldToStats < ActiveRecord::Migration
  def self.up
		add_column :statistics, :calculated, :boolean
  end

  def self.down
  end
end
