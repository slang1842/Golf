class AddColumnsToHoles < ActiveRecord::Migration
  def self.up
  	add_column :holes, :very_short_distance, :float
  	add_column :holes, :short_distance, :float
  	add_column :holes, :normal_distance, :float
  	add_column :holes, :long_distance, :float
  end

  def self.down
  	remove_column :holes, :very_short_distance, :float
  	remove_column :holes, :short_distance, :float
  	remove_column :holes, :normal_distance, :float
  	remove_column :holes, :long_distance, :float
  end
end
