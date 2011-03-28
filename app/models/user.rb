class User < ActiveRecord::Base
  belongs_to :golf_club
    
  acts_as_authentic do |c| 
    c.login_field = :email 
  end
  
  SEX_TO_DB = { "female" => "f", "male" => "m" }
  SEX_FROM_DB = { "f" => "female", "m" => "male" }
  
  #RIGHT_HANDED_TO_DB = { "Labrocis" => true, "Kreilis" => false }
  #RIGHT_HANDED_FROM_DB ={ true => "Labrocis", false => "Kreilis" }
  
  
  def is_club_admin_or_owner(club)
    return ((admin && golf_club.id == club.id) || id == club.user_id)
  end

end
