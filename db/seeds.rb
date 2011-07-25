# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#Add Countrys



lv = Country.create(:name => 'Latvia')
it = Country.create(:name => 'Italy')

Stick.create(:stick_type => 'ORIONIONIN',
  :distance => 100,
  :degrees => 35,
  :shaft => "metal",
  :short_name => "O",
  :shaft_strength => "strong")
              

Stick.create(:stick_type => "PUTTER",
  :distance => "210",
  :degrees => "34",
  :shaft => "wood",
  :short_name => "P",
  :shaft_strength => "strong")
              
              
Stick.create(:stick_type => "DRIVER",
  :distance => "160",
  :degrees => "14",
  :shaft => "metal",
  :short_name => "D",
  :shaft_strength => "very strong")
              
Stick.create(:stick_type => "WOODBOW",
  :distance => "410",
  :degrees => "45",
  :shaft => "wood",
  :short_name => "W",
  :shaft_strength => "medium strong")



