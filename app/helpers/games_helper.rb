module GamesHelper
	def shorten_2 number
		truncated = (number).ceil if number
		return truncated
	end

	def game_header(field_name, gamedate)
		return_text = 'Game on field "' + field_name + '"'
		if gamedate != nil
			gamedate = gamedate.strftime("%d %B %Y")
			return_text += ", " + gamedate
		end
		raw return_text
	end

	def render_hole_color(hole_number)
		case session[:hole_statuses][:"#{hole_number}"]
			when nil
				return_text = "empty"
			when 1
				return_text = "half_done"
			when 2
				return_text = "done"
		end
		raw return_text
	end

	def render_hit_color(hit_number)
		case session[:hit_statuses][:"#{hit_number.to_s}"]
			when nil
				return_text = "half_done"
			when 1
				return_text = "done"
		end
		raw return_text
	end

	def return_stick_name(hit_number)
		name = session[:stick_names][:"#{hit_number.to_s}"]
		if name == nil	
			name = hit_number.to_s + "."
		end
		raw name
	end

end
