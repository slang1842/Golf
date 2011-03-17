class CountryList < ActiveRecord::Migration
  def self.up
    create_table :CountryList do |t|
    
      t.string :country
    
  end

  def self.down
   drop_table :CountryList
  end
end
