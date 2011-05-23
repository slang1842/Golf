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
             

PairHit.create(:users_id => 1,
  :hit_planed_id => 7,
  :hit_real_id => 8,
  :users_stick_id => 3)                
            
GolfClub.create(:user_id => 1,
  :name => "OZO",
  :country_id => 1,
  :region => "Rīgas raj",
  :city => "Rīga",
  :web_page => "www.ozo.lv",
  :accepted => "unknown",
  :active => false)

Game.create(:id => 1,
  :user_id => 1,
  :field_quality => "field_quality",
  :green_quality => "green_quality",
  :temperature => 3,
  :weather => 2,
  :field_id => 1)
   
Game.create(:id => 2,
  :user_id => 1,
  :field_quality => "field_quality",
  :green_quality => "green_quality",
  :temperature => 3,
  :weather => 2,
  :field_id => 1)
              
   
Game.create(:id => 3,
  :user_id => 1,
  :field_quality => "field_quality",
  :green_quality => "green_quality",
  :temperature => 3,
  :weather => 2,
  :field_id => 1)
              
   
Game.create(:id => 4,
  :user_id => 2,
  :field_quality => "field_quality",
  :green_quality => "green_quality",
  :temperature => 3,
  :weather => 2,
  :field_id => 1)
              

Field.create(:golf_club_id => 1,
  :name => "Viesturi",
  :very_short_distance => 1,
  :short_distance => 2,
  :normal_distance => 3,
  :long_distance => 4)    

Field.create(:golf_club_id => 1,
  :name => "Cits laukums",
  :very_short_distance => 1,
  :short_distance => 2,
  :normal_distance => 3,
  :long_distance => 4)

Hit.create(:game_id => 1,
  :user_id => 1,
  :hole_id => 1,
  :stick_id => 1,
  :real_hit => "pp",
  :hole_number => 1,
  :hit_number => 1,
  :hit_distance => 200,
  :place_from => 1,
  :land_place => 1,
  :stance => 3,
  :trajectory => 2,
  :wind => 3,
  :hit_was => 1,
  :motion_was => 2,
  :direction => 3,
  :pair_id => 1)
            

Hit.create(:game_id => 1,
  :user_id => 1,
  :hole_id => 1,
  :stick_id => 1,
  :real_hit => "rp",
  :hole_number => 1,
  :hit_number => 1,
  :hit_distance => 100,
  :place_from => 1,
  :land_place => 2,
  :stance => 1,
  :trajectory => 3,
  :wind => 2,
  :hit_was => 3,
  :motion_was => 1,
  :direction => 3,
  :pair_id => 1)
              
              
            
Hit.create(:game_id => 2,
  :user_id => 2,
  :hole_id => 2,
  :stick_id => 1,
  :real_hit => "pp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 400,
  :place_from => 1,
  :land_place => 3,
  :stance => 2,
  :trajectory => 2,
  :wind => 4,
  :hit_was => 2,
  :motion_was => 3,
  :direction => 2,
  :pair_id => 2)

Hit.create(:game_id => 2,
  :user_id => 2,
  :hole_id => 2,
  :stick_id => 1,
  :real_hit => "rp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 600,
  :place_from => 1,
  :land_place => 3,
  :stance => 4,
  :trajectory => 3,
  :wind => 4,
  :hit_was => 3,
  :motion_was => 2,
  :direction => 2,
  :pair_id => 2)
           
            
Hit.create(:game_id => 2,
  :user_id => 2,
  :hole_id => 2,
  :stick_id => 1,
  :real_hit => "pp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 400,
  :place_from => 1,
  :land_place => 3,
  :stance => 2,
  :trajectory => 3,
  :wind => 3,
  :hit_was => 2,
  :motion_was => 1,
  :direction => 2,
  :pair_id => 2)

Hit.create(:game_id => 2,
  :user_id => 2,
  :hole_id => 2,
  :stick_id => 1,
  :real_hit => "rp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 350,
  :place_from => 1,
  :land_place => 2,
  :stance => 2,
  :trajectory => 3,
  :wind => 4,
  :hit_was => 2,
  :motion_was => 1,
  :direction => 2,
  :pair_id => 2)

Hit.create(:game_id => 2,
  :user_id => 2,
  :hole_id => 2,
  :stick_id => 1,
  :real_hit => "pp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 100,
  :place_from => 1,
  :land_place => 3,
  :stance => 2,
  :trajectory => 3,
  :wind => 2,
  :hit_was => 3,
  :motion_was => 1,
  :direction => 2,
  :pair_id => 2)

Hit.create(:game_id => 2,
  :user_id => 2,
  :hole_id => 2,
  :stick_id => 1,
  :real_hit => "rp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 150,
  :place_from => 1,
  :land_place => 2,
  :stance => 2,
  :trajectory => 3,
  :wind => 4,
  :hit_was => 3,
  :motion_was => 2,
  :direction => 2,
  :pair_id => 2)
            
Hit.create(:game_id => 2,
  :user_id => 1,
  :hole_id => 2,
  :stick_id => 1,
  :real_hit => "pp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 310,
  :place_from => 1,
  :land_place => 3,
  :stance => 4,
  :trajectory => 3,
  :wind => 4,
  :hit_was => 1,
  :motion_was => 1,
  :direction => 3,
  :pair_id => 3)
            
Hit.create(:game_id => 2,
  :user_id => 1,
  :hole_id => 2,
  :stick_id => 1,
  :real_hit => "rp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 10,
  :place_from => 1,
  :land_place => 3,
  :stance => 4,
  :trajectory => 3,
  :wind => 4,
  :hit_was => 3,
  :motion_was => 2,
  :direction => 4,
  :pair_id => 3)
            
Hit.create(:game_id => 2,
  :user_id => 1,
  :hole_id => 3,
  :stick_id => 1,
  :real_hit => "pp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 100,
  :place_from => 1,
  :land_place => 3,
  :stance => 4,
  :trajectory => 3,
  :wind => 4,
  :hit_was => 3,
  :motion_was => 2,
  :direction => 4,
  :pair_id => 3)
            
Hit.create(:game_id => 2,
  :user_id => 1,
  :hole_id => 3,
  :stick_id => 1,
  :real_hit => "rp",
  :hole_number => 1,
  :hit_number => 2,
  :hit_distance => 200,
  :place_from => 1,
  :land_place => 3,
  :stance => 4,
  :trajectory => 3,
  :wind => 4,
  :hit_was => 3,
  :motion_was => 1,
  :direction => 4,
  :pair_id => 3)
              
PairHit.create(:users_id => 1,
  :hit_planed_id => 1,
  :hit_real_id => 2,
  :users_stick_id => 1) 

PairHit.create(:users_id => 2,
  :hit_planed_id => 3,
  :hit_real_id => 4,
  :users_stick_id => 2) 

PairHit.create(:users_id => 1,
  :hit_planed_id => 5,
  :hit_real_id => 6,
  :users_stick_id => 3)
                
PairHit.create(:users_id => 1,
  :hit_planed_id => 7,
  :hit_real_id => 8,
  :users_stick_id => 2)
                
PairHit.create(:users_id => 2,
  :hit_planed_id => 9,
  :hit_real_id => 10,
  :users_stick_id => 1)
                
PairHit.create(:users_id => 2,
  :hit_planed_id => 11,
  :hit_real_id => 12,
  :users_stick_id => 1)
              

Hole.create(:field_id => 1,
  :par => 1,
  :hcp => 2,
  :hole_number => 1)
              
Hole.create(:field_id => 1,
  :par => 1,
  :hcp => 2,
  :hole_number => 2)
              
Hole.create(:field_id => 1,
  :par => 1,
  :hcp => 2,
  :hole_number => 3)
              
Hole.create(:field_id => 1,
  :par => 1,
  :hcp => 2,
  :hole_number => 4)
              
Hole.create(:field_id => 1,
  :par => 1,
  :hcp => 2,
  :hole_number => 5)
              
Hole.create(:field_id => 1,
  :par => 1,
  :hcp => 2,
  :hole_number => 6)
              
Hole.create(:field_id => 1,
  :par => 1,
  :hcp => 2,
  :hole_number => 7)
              
Hole.create(:field_id => 1,
  :par => 1,
  :hcp => 2,
  :hole_number => 8)
              
Hole.create(:field_id => 1,
  :par => 1,
  :hcp => 2,
  :hole_number => 9)
              
              
              
              
              
              