class CreateGreenFees < ActiveRecord::Migration
  def self.up
    create_table :green_fees do |t|
      t.references :field
      t.string :title,     :null => false
      t.integer :price,    :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :green_fees
  end
end
