class CreatePairHits < ActiveRecord::Migration
  def self.up
    create_table :pair_hits do |t|
      #t.integer         :pair_id
      t.references      :hit_planed
      t.references      :hit_real
      t.references      :users_stick
      t.references      :users
      t.timestamps
    end
  end

  def self.down
    drop_table :pair_hits
  end
end
