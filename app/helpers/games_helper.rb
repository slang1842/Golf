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
		if name == "penalty" then name = "Pen" end
		if name == nil	
			name = hit_number.to_s + "."
		else
			name = hit_number.to_s + "." + name
		end
		raw name
	end

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

	def fetch_color_for_plan_button(game_id)
		return_text = "gray_button"
		game_holes(game_id)
		hits = []
		@holes.each do |hole|
			hit = Hit.where(:game_id => game_id, :hole_number => hole.hole_number, :real_hit => "p").last
			hits << hit if hit
		end
		if hits.size > 0
			hits.each do |hit|
				puts hit.land_place
				if hit.land_place == 11
					return_text = "green_button"
				else
					return_text = "yellow_button"
				end
			end
		else
			return_text = "gray_button"
		end
		raw return_text
	end

	def fetch_color_for_details_button(game)
		return_text = "gray_button"
		if game.complete == true
			return_text = "green_button"
		else
			status_holes = StatusHole.where(:game_id => game.id)
			if status_holes.any?
				status_holes.each do |hole|
					if hole.completeness.to_i == 2 then return_text = "green_button" else return_text = "yellow_button" end
				end
				if return_text == "green_button"
					game.update_attributes(:complete => 1)
				elsif return_text == "yellow_button"
					
				else
				return_text = "gray_button"
				end
			end
		end
		raw return_text		
	end

	def game_holes(game_id)
    @game = Game.find(game_id)
    game_type = @game.game_type
    @holes = Hole.where(:field_id => @game.field_id)
    case game_type
      when 1
        hole_num = 1..9  
        @start_hole = 1
        @end_hole = 9
      when 2
        hole_num = 10..18
        @start_hole = 10 
        @end_hole = 18
      when 3
        hole_num = 1..18
        @start_hole = 1
        @end_hole = 18   
    end
    @holes_filtered = @holes.where(:hole_number => hole_num)
  end
end
