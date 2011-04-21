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
              
Hit.create (:user_id => 1,
            :real_hit => false,
            :stance => "stavus",
            :distance_to_hole => 180)
              
Hit.create (:user_id => 1,
            :real_hit => true,
            :stance => "stavus",
            :distance_to_hole => 210)
              
PairHit.create (
            #:pair_id => 1,
            :user_id => 1,
            :hit_planed => 1,
            :hit_real => 2)              
              
Hit.create (:game_id => 1,
            :user_id => 1,
            :hole_id => 1,
            :real_hit => "pp",
            :hole_number => 1,
            :hit_number => 1,
            :hit_distance => 200,
            :place_from => "green sand",
            :land_place => "teebox",
            :stance => "Right leg lower",
            :trajectory => "low",
            :put_or_hit => false,
            :wind => "from_left",
            :hit_was => "under",
            :motion_was => "top",
            :direction => "taisni")

Hit.create (:game_id => 1,
            :user_id => 1,
            :hole_id => 1,
            :real_hit => "rp",
            :hole_number => 1,
            :hit_number => 1,
            :hit_distance => 300,
            :place_from => "green sand",
            :land_place => "teebox",
            :stance => "Right leg lower",
            :trajectory => "low",
            :put_or_hit => false,
            :wind => "crosswind",
            :hit_was => "under",
            :motion_was => "top",
            :direction => "taisni")
              
              
            
Hit.create (:game_id => 3,
            :user_id => 2,
            :hole_id => 1,
            :real_hit => "rp",
            :hole_number => 1,
            :hit_number => 2,
            :hit_distance => 200,
            :place_from => "green sand",
            :land_place => "teebox",
            :stance => "Right leg lower",
            :trajectory => "low",
            :put_or_hit => false,
            :wind => "from_left",
            :hit_was => "under",
            :motion_was => "top",
            :direction => "taisni")

Hit.create (:game_id => 3,
            :user_id => 2,
            :hole_id => 1,
            :real_hit => "pp",
            :hole_number => 1,
            :hit_number => 2,
            :hit_distance => 320,
            :place_from => "green sand",
            :land_place => "teebox",
            :stance => "Right leg lower",
            :trajectory => "low",
            :put_or_hit => false,
            :wind => "crosswind",
            :hit_was => "under",
            :motion_was => "top",
            :direction => "taisni")
              
              
GolfClub.create (:user_id => 1,
                 :name => "OZO",
                 :country_id => 1,
                 :region => "Rīgas raj",
                 :city => "Rīga",
                 :web_page => "www.ozo.lv",
                 :accepted => "unknown",
                 :active => false)
              
              
              
              
              
              
              
              
              
              
              
              
              