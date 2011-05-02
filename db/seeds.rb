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


Stick.create (:stick_type => 'ORIONIONIN',
              :distance => 100,
              :degrees => 35,
              :shaft => "metal",
              :shaft_strength => "strong")
              

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
              
Hit.create (:game_id => 1,
            :user_id => 1,
            :hole_id => 1,
            :stick_id => 1,
            :real_hit => "rp",
            :hole_number => 1,
            :hit_number => 1,
            :hit_distance => 200,
            :place_from => 1,
            :land_place => 1,
            :stance => 3,
            :trajectory => 2,
            :put_or_hit => false,
            :wind => 3,
            :hit_was => "under",
            :motion_was => "top",
            :direction => 3,
            :pair_id => 1)
            

Hit.create (:game_id => 1,
            :user_id => 1,
            :hole_id => 1,
            :stick_id => 1,
            :real_hit => "rp",
            :hole_number => 1,
            :hit_number => 1,
            :hit_distance => 300,
            :place_from => 1,
            :land_place => 2,
            :stance => 1,
            :trajectory => 3,
            :put_or_hit => false,
            :wind => "From front",
            :hit_was => "under",
            :motion_was => "top",
            :direction => 3,
            :pair_id => 1)
              
              
            
Hit.create (:game_id => 2,
            :user_id => 1,
            :hole_id => 2,
            :stick_id => 1,
            :real_hit => "rp",
            :hole_number => 1,
            :hit_number => 2,
            :hit_distance => 400,
            :place_from => 1,
            :land_place => 3,
            :stance => 2,
            :trajectory => 2,
            :put_or_hit => false,
            :wind => "From behind",
            :hit_was => "under",
            :motion_was => "top",
            :direction => 2,
            :pair_id => 2)

Hit.create (:game_id => 2,
            :user_id => 1,
            :hole_id => 2,
            :stick_id => 1,
            :real_hit => "pp",
            :hole_number => 1,
            :hit_number => 2,
            :hit_distance => 520,
            :place_from => 1,
            :land_place => 3,
            :stance => 4,
            :trajectory => 3,
            :put_or_hit => false,
            :wind => 4,
            :hit_was => "under",
            :motion_was => "top",
            :direction => 2,
            :pair_id => 2)

Hit.create (:game_id => 2,
            :user_id => 1,
            :hole_id => 2,
            :stick_id => 1,
            :real_hit => "pp",
            :hole_number => 1,
            :hit_number => 2,
            :hit_distance => 320,
            :place_from => 2,
            :land_place => 3,
            :stance => 4,
            :trajectory => 3,
            :put_or_hit => false,
            :wind => 4,
            :hit_was => "under",
            :motion_was => "top",
            :direction => 3,
            :pair_id => 3)
            
Hit.create (:game_id => 2,
            :user_id => 1,
            :hole_id => 2,
            :stick_id => 1,
            :real_hit => "pp",
            :hole_number => 1,
            :hit_number => 2,
            :hit_distance => 520,
            :place_from => 2,
            :land_place => 3,
            :stance => 4,
            :trajectory => 3,
            :put_or_hit => false,
            :wind => 4,
            :hit_was => "under",
            :motion_was => "top",
            :direction => 4,
            :pair_id => 3)
              
PairHit.create (:users_id => 1,
                :hit_planed_id => 1,
                :hit_real_id => 2,
                :users_stick_id => 1) 

PairHit.create (:users_id => 2,
                :hit_planed_id => 3,
                :hit_real_id => 4,
                :users_stick_id => 2)             
            
GolfClub.create (:user_id => 1,
                 :name => "OZO",
                 :country_id => 1,
                 :region => "Rīgas raj",
                 :city => "Rīga",
                 :web_page => "www.ozo.lv",
                 :accepted => "unknown",
                 :active => false)

Game.create (:id => 1,
             :field_quality => "field_quality",
             :green_quality => "green_quality",
             :temperature => 3,
             :weather => 2)
             
Game.create (:id => 2,
             :field_quality => "field_quality",
             :green_quality => "green_quality",
             :temperature => 2,
             :weather => 3)
              
              
              
              
              
              
              
              
              
              
              