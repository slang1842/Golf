class CreateAllStickStatistics < ActiveRecord::Migration
  def self.up
    create_table :all_stick_statistics do |t|
      t.references     :user
      t.references     :stick
      t.integer        :usage
      t.integer        :avg_distance
      t.integer        :stick_progres
      t.timestamps
    end
  end

  def self.down
    drop_table :all_stick_statistics
  end
end
