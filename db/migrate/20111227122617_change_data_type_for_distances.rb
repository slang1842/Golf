class ChangeDataTypeForDistances < ActiveRecord::Migration
   def self.up
    change_table :hits do |t|
			t.remove :distance_to_hole
      t.remove :hit_distance
			t.column :distance_to_hole, :float
      t.column :hit_distance, :float
    end
		change_table :sticks do |t|
			t.remove :distance
			t.column :distance, :float
		end
		
		change_table :holes do |t|
			t.remove :distance
			t.column :distance, :float
		end

		change_table :fields do |t|
			t.remove :very_short_distance
      t.remove :short_distance
     	t.remove :normal_distance
   		t.remove :long_distance
			t.column :very_short_distance, :string
      t.column :short_distance, :string
     	t.column :normal_distance, :string
   		t.column :long_distance, :string
		end

		change_table :users_sticks do |t|
			t.remove :distance
			t.column :distance, :float
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

