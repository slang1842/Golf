module UserHelper

	def convert_distance(distance)
		if distance	
			case current_user.measurement
				when "yards"
					distance = distance.to_i / 0.9144
				when "foots"
					distance = distance.to_i / 0.3048
				when "meters"
					distance = distance.to_i
			end
			return distance.ceil
		else 
			return 0
		end
					
	end		
end
