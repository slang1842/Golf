module FieldsHelper

	def convert_distances(distance)
		if distance 
		 distance = Stick.convert_distance_from_meters(current_user.measurement, distance).ceil		
		else distance = 0
		end
		return distance	
	end

	def return_style(color_number)
		if color_number.to_i == 0
			style = "display:none"
		else
			style = ""
		end
		return style
	end

	def return_color(current_field, distance)
		case distance.to_i
			when 1
				if current_field.very_short_distance != 0 then color = return_color_from_number(current_field.very_short_distance) else color = "Very short distance" end
			when 2
				if current_field.short_distance != 0 then color = return_color_from_number(current_field.short_distance) else color = "Short distance" end
			when 3
				if current_field.normal_distance != 0 then color = return_color_from_number(current_field.normal_distance) else color = "Normal distance" end
			when 4
				if current_field.long_distance != 0 then color = return_color_from_number(current_field.long_distance) else color = "Long distance" end
			end	
		return color
	end

	def return_color_from_number(number)
		case number.to_i
			when 1
				color = "Red"
			when 2
				color = "Green"
			when 3 
				color = "Black"
			when 4
				color = "Yellow"
			end
		return color
	end

end
