module StatisticsHelper

	def swap_bar_color(percentage)
		if percentage.to_i < 60
			return "bad"
		elsif percentage.to_i > 80
			return "good"
		else
    	return "normal"
		end

	end

	def fetch_coach(user_id)
		if user_id && user_id != nil
			user = User.find(user_id)
			raw user.first_name + " " + user.last_name
		end	
	end

end
