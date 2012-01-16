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

end
