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

#Add Club - viesturi
club = GolfClub.create(
  #:owner => 'admin',
  :name => 'Viesturi',
  #:country => 1,
  :region => 'Rīga',
  :city => 'Rīga',
  :accepted => "no",
  #:countries => lv,
  :web_page => 'www.viesturi.lv',
  :start_place_by_level_low => 1,
  :start_place_by_level_medium => 2,
  :start_place_by_level_high => 4)

  
#Add Club - ozo
club2 = GolfClub.create(
  #:owner => 'admin',
  :name => 'OZO',
  #:country => 1,
  :region => 'Rīga',
  :city => 'Rīga',
  :accepted => "yes",
  #:countries => it,
  :web_page => 'www.ozo.lv',
  :start_place_by_level_low => 1,
  :start_place_by_level_medium => 2,
  :start_place_by_level_high => 4)

    
#Add users - admin
User.create(
  :email => 'admin@admin.com',
  :password => 'admin',
  :password_confirmation => 'admin',
  :admin => true,
  :first_name => 'Edgars',
  :last_name => 'Liepa',
  :golf_club => club,
  :hcp => 23
)


#Add users - admin2
User.create(
  :email => 'admin2@admin.com',
  :password => 'admin2',
  :password_confirmation => 'admin2',
  :admin => true,
  :first_name => 'Edgars',
  :last_name => 'Liepa',
  :golf_club => club2,
  :hcp => 23
)

#Add users - user
User.create(
  :email => 'user@user.com',
  :password => 'user',
  :password_confirmation => 'user',
  :admin => false,
  :first_name => 'Edgars2',
  :last_name => 'Liepa2',
  :golf_club => club,
  :hcp => 22
)








