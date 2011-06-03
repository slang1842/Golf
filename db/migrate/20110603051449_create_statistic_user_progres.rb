class CreateStatisticUserProgres < ActiveRecord::Migration
  def self.up
    create_table :statistic_user_progres do |t|
      t.references    :user
      t.references    :field
      t.integer       :hcp
      t.integer       :user_progress
      t.timestamps
    end
  end

  def self.down
    drop_table :statistic_user_progres
  end
end
