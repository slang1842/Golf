class GolfClub < ActiveRecord::Base
 
  
	#def check_club_status
		#if club_accepted && is_owner
		#	return true
		#end
       
	#end
	
  def is_admin(user_id)
    unless golf_club(user_id.golf_club.id) != nil
      return true
    end
  end
  
	def club_accepted
		if club.accepted
			return true
		end
	end
	
  def is_owner(user_id)
		unless club.user_id != current_user.id
			return true
		end
  end

  def to_s
    self.name
  end
  
  
end