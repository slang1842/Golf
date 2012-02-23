class ChangeDataTypeForDistances < ActiveRecord::Migration
   def self.up
    change_table :hits do |t|
			t.remove_column :distance_to_hole
      t.remove_column :hit_distance
			t.add_column :distance_to_hole, :float
      t.add_column :hit_distance, :float
    end
		change_table :sticks do |t|
			t.remove_column :distance
			t.add_column :distance, :float
		end
		
		change_table :holes do |t|
			t.remove_column :distance
			t.add_column :distance, :float
		end

		change_table :fields do |t|
			t.remove_column :very_short_distance
      t.remove_column :short_distance
     	t.remove_column :normal_distance
   		t.remove_column :long_distance
			t.add_column :very_short_distance, :string
      t.add_column :short_distance, :string
     	t.add_column :normal_distance, :string
   		t.add_column :long_distance, :string
		end

		change_table :users_sticks do |t|
			t.remove_column :distance
			t.add :distance, :float
		end
  end

  def self.down
    change_table :hits do |t|
			t.change :distance_to_hole, :integer
      t.change :hit_distance, :integer
    end
		change_table :sticks do |t|
			t.change :distance, :integer
		end
		
		change_table :holes do |t|
			t.change :distance, :integer
		end
		
		change_table :fields do |t|
			t.change :very_short_distance, :integer
   		t.change :short_distance, :integer
   		t.change :normal_distance, :integer
   		t.change :long_distance, :integer
		end

		change_table :users_sticks do |t|
			t.change :distance, :string
		end

  end
end

