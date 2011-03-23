class User < ActiveRecord::Base
  belongs_to :golf_club
 
    #def is_club_admin_or_owner(club)
    #  if ((admin && golf_club.id == club.id) || id == club.user_id)
    #    return true
    #  else
    #    return false
    #  end
    #end
    
  acts_as_authentic do |c| 
    c.login_field = :email 
  end
  
  SEX_TO_DB = { "female" => "f", "male" => "m" }
  SEX_FROM_DB = { "f" => "female", "m" => "male" }
  
  RIGHT_HANDED_TO_DB = { "Labrocis" => true, "Kreilis" => false }
  RIGHT_HANDED_FROM_DB ={ true => "Labrocis", false => "Kreilis" }
  
  #MEASUREMENT_TO_DB = { (t "form.measurement_m") => "Meters", "form.measurement_f") => "Foots" }
  #MEASUREMENT_FROM_DB{ "Meters" => "form.measurement_m", "Foots" => t "form.measurement_m" }
  
  
end
