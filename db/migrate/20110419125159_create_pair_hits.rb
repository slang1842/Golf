class CreatePairHits < ActiveRecord::Migration
  def self.up
    create_table :pair_hits do |t|
      #t.integer         :pair_id
      t.references      :user
      t.integer         :hit_planed
      t.integer         :hit_real
      
      t.timestamps
    end
  end

  def self.down
    drop_table :pair_hits
  end
end
