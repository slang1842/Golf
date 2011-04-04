class GolfClub < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  has_many :fields
	/
  def is_owner(user_id)
		unless club.user_id != current_user.id
			return true
	  end
  end
/
  def to_s
    self.name
  end
  
  
end