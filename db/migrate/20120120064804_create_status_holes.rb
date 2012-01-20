class CreateStatusHoles < ActiveRecord::Migration
  def self.up
    create_table :status_holes do |t|
			t.references :game
			t.integer :hole_number
			t.integer :completeness
      t.timestamps
    end
  end

  def self.down
    drop_table :status_holes
  end
end
