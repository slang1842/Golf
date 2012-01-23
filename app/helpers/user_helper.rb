module UserHelper

=begin
	def convert_distance(distance)
		if distance	
			case current_user.measurement
				when "m"
					distance = distance.to_i / 0.9144
				when "ft"
					distance = distance.to_i / 0.3048
				when "yd"
					distance = distance.to_i
			end
			return distance.ceil
		else 
			return 0
		end
					
	end		
=begin
	def return_distance_name(distance_type)
		case distance_type
			when "m"
				distance = "meters"
			when "ft"
				distance = "feet"
			when "yd"
				distance = "yards"
			else
				distance = "somehow not defined"
			end
		return distance

	end
=end
end
