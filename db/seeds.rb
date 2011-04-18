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

              
              
User.create (:email => "user@user.com",
             :crypted_password => "992b62b1a6496c0f2c66767aee0b19303f63dddb78c54ccecd",
             :password_salt => "EoyPOUs3Gz1FnUUc8Vfr",
             :persistence_token => "3e69da90796025ce4cf240461a63e9399e733434057130b5e3",
             :admin => false,
             :is_super_admin => false,
             :is_blocked => false,
             :first_name => "user name",
             :last_name => "user surname",
             :nick => "user nick",
             :sex => "f",
             :birth => "25-06-1990",
             # :country => 1,
             :golf_club => nil,
             :hcp => "22",
             :right_handed => true,
             :measurement => "meters",
             :start_place_color => 1,
             :temp_preference => "celsium")

Stick.create (:stick_type => "PUTTER",
              :distance => "210",
              :degrees => "34",
              :shaft => "wood",
              :shaft_strength => "strong")
              
              
Stick.create (:stick_type => "DRIVER",
              :distance => "160",
              :degrees => "14",
              :shaft => "metal",
              :shaft_strength => "very strong")
              
Stick.create (:stick_type => "WOODBOW",
              :distance => "410",
              :degrees => "45",
              :shaft => "wood",
              :shaft_strength => "medium strong")
              
              
              
              
              
              
              
              
              
              
              