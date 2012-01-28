class CreateSingleFieldStatistics < ActiveRecord::Migration
  def self.up
    create_table :single_field_statistics do |t|
			t.references :user
			t.references :field
      t.timestamps
    end
  end

  def self.down
    drop_table :single_field_statistics
  end
end
