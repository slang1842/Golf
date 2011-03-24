# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#Add Countrys

Country.create(:name => 'Latvia')
Country.create(:name => 'Italy')


#Add Club
club = GolfClub.create(
  #:owner => 'admin',
  :name => 'Viesturi',
  #:country => 'Latvia',
  :region => 'Rīga',
  :city => 'Rīga',
  :web_page => 'www.viesturi.lv',
  :start_place_by_level_low => '1',
  :start_place_by_level_medium => '2',
  :start_place_by_level_high => '4')




#Add users
User.create(
  :email => 'admin@admin.com',
  :password => 'admin',
  :password_confirmation => 'admin',
  #:user_type => 'admin',
  :admin => true,
  :first_name => 'Edgars',
  :last_name => 'Liepa',
  :golf_club => club,
  :hcp => 23
)

User.create(
  :email => 'user@user.com',
  :password => 'user',
  :password_confirmation => 'user',
  :first_name => 'Edgars',
  :last_name => 'Liepa',
  :golf_club => club,
  :hcp => 23
)







