class CreateSideAds < ActiveRecord::Migration
  def self.up
    create_table :side_ads do |t|
			t.references :golf_club
			t.string :header
			t.string :body
			t.string :link
			t.boolean :to_be_shown
      t.timestamps
    end
  end

  def self.down
    drop_table :side_ads
  end
end
