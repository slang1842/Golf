class CreateHoles < ActiveRecord::Migration
  def self.up
    create_table :holes do |t|
      t.references :field
      t.integer :par
      t.integer :hcp
      t.integer :white
      t.integer :blue
      t.integer :red

      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :holes
  end
end
