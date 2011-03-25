class GolfClub < ActiveRecord::Base
	
	def check_club_status
		if club_accepted && is_owner
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

end