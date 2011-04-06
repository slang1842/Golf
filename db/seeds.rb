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

Stick.create (:stick_type => 'PUTER',
              :distance => 100,
              :degrees => 35,
              :shaft => "wood",
              :shaft_strength => "strong")

Stick.create (:stick_type => 'ORIONIONIN',
              :distance => 100,
              :degrees => 35,
              :shaft => "metal",
              :shaft_strength => "strong")

UsersStick.create (:user_id => 1,
                   :stick_id => 1,
                   :distance => 100,
                   :degrees => 35,
                   :shaft_strength => "strong")
             

UsersStick.create (:user_id => 1,
                   :stick_id => 1,
                   :distance => 120,
                   :degrees => 25,
                   :shaft_strength => "middle")