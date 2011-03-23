class GolfClub < ActiveRecord::Base

    def is_owner(user_id)
      unless club.user_id != current_user.id
      return true
      end
    end
    
end
