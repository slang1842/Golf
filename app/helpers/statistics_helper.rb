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

end
