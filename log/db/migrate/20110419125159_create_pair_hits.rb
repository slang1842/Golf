class CreatePairHits < ActiveRecord::Migration
  def self.up
    create_table :pair_hits do |t|
      #t.integer         :pair_id
      t.integer         :hit_planed_id
      t.integer         :hit_real_id
      t.references      :users_stick
      t.references      :user
      t.references      :game
      t.timestamps
    end
  end

  def self.down
    drop_table :pair_hits
  end
end
