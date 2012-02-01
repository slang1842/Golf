class Statistic < ActiveRecord::Base
  belongs_to   :user
  has_many    :hits
  has_many    :fields
  belongs_to  :hole
  scope :game, :joins => {:game => :hit}
  scope :stick, :joins => {:stick => :user_stick}

  
  def self.get_average_from_array(arr)
    @result
    
    arr.each do |arre|
      @result = @result + arre
    end
    
    @restult = @result.to_f / arr.size
    return @result
  end
  
  def self.calculate_diference(p, r)
    if p == nil or r == nil
      return false
    else
      @diference = (p - r).abs
    
      case @diference
      when 0
        return 3
      when 1
        return 5 # - 5% from hit
      when 2
        return  12
      when 3
        return 15
      when 4
        return  18
      when 5
        return  22
      when 6
        return 25
      else
        return  30
      end
    end   
  end
  
  def self.calculate_current_statistics(planed, real) # p = planed, r = Real
		if planed.real_hit == "penalty"
			result = 1
		else
      if planed.hit_distance.to_i != 0 && real.hit_distance.to_i != 0 && real.misdirection.to_i != 0 && real.mistake.to_i != 0    
      	result = calculate_distance_ratio(planed.hit_distance, real.hit_distance)
        	 result = result - detect_failed_stroke(real.misdirection, 2) # 3 is for misdirection "straight"
        	 result = result - detect_failed_stroke(real.mistake, 2) # 1 is for mistake "none"  
					 result = result - compare_land_places(real.land_place, planed.land_place) 
      	if result > 100
        	result = 100
      	elsif result < 1
        	result = 1
      	end
			else
				result = false
			end
		end
  	return result
  end

	def self.compare_land_places(real_place, planned_place)
		if real_place != planned_place
				result = 30
		else
			result = 0
		end
		return result
	end	

  def self.calculate_success_ratio_for_trajectory(real_pt, planned_pt)
		if real_pt != nil && planned_pt != nil 
    	diff = (real_pt - planned_pt).abs 
    	if diff < 5
      	result = diff * 15
    	else
      	if planned_pt == 5 || real_pt == 5
      	  diff = diff - 5
      	  result = diff.abs * 15
     		else
        	result = 15
      	end
    	end
    	return result
		else
			return 0
		end
  end
  
  def self.detect_failed_stroke(actual_pt, success_pt)
		diff = actual_pt - success_pt
    if diff.abs == 0
      return 0
    elsif diff.abs == 1
      return 15
		else
			return 30
    end
  end
	
  def self.calculate_success_ratio(planned_pts, real_pts, total_pts)
		if planned_pts != nil && real_pts != nil
			distance_ratio = ((1 - (distance_real.to_f - distance_planned.to_f).abs / distance_planned).to_f.round(2) * 100).round
			planned_ratio = ((((planned_pts - real_pts) / total_pts).abs.round(2)) * 100).round
			result = planned_ratio
		else 
			result = 0
		end
		if result < 1
			result = 1
		end

	return result

	end

  def self.calculate_distance_ratio(distance_planned, distance_real)
		if distance_planned != nil && distance_real != nil
    	distance_ratio = ((1 - (distance_real.to_f - distance_planned.to_f).abs / distance_planned).to_f.round(2) * 100).round
		else
			distance_ratio = 0
		end
    return distance_ratio
  end
  
  def self.main_statistics

    @return = false
    User.where(:is_super_admin => false).includes("statistics").includes("sticks").includes("hits").each do |c_user|
			StandardStatistic.calculate_user_stats(c_user.id)
			c_user.users_sticks.each do |user_stick|
			statistic = Statistic.find_or_create_by_user_id_and_stick_id(c_user.id, user_stick.stick_id)
			if statistic.calculated == false || statistic.calculated == nil
				#these variables have to be defined somewhere, hence the mess                       
									@statistic_place_teebox = 0
									@statistic_place_teebox_count = 1        
                  @statistic_place_feairway = 0
									 @statistic_place_feairway_count = 1             					
                  @statistic_place_next_fairway = 0
									@statistic_place_next_fairway_count = 1        
                  @statistic_place_semi_raf = 0
									@statistic_place_semi_raf_count = 1          
                  @statistic_place_raf = 0
									@statistic_place_raf_count = 1            
                  @statistic_place_for_green = 0 
									@statistic_place_for_green_count = 1         
                  @statistic_place_green = 0 
									@statistic_place_green_count = 1           
                  @statistic_place_fairway_sand = 0
									@statistic_place_fairway_sand_count = 1           
                  @statistic_place_green_sand = 0
									@statistic_place_green_sand_count = 1             
                  @statistic_place_wood = 0 
									@statistic_place_wood_count = 1			        
                  @statistic_place_from_water = 0
									@statistic_place_from_water_count = 1             
                  @statistic_stance_normal = 0
									@statistic_stance_normal_count = 1          
                  @statistic_stance_right_leg_lower = 0
									@statistic_stance_right_leg_lower_count = 1               
                  @statistic_stance_left_leg_lower = 0
									@statistic_stance_right_leg_lower_count = 1                   
                  @statistic_stance_ball_lower = 0
									@statistic_stance_ball_lower_count = 1             
                  @statistic_stance_ball_higher = 0
									@statistic_stance_ball_higher_count = 1           
                  @statistic_temperature_hot = 0
									@statistic_temperature_hot_count = 1             
                  @statistic_temperature_normal = 0
									@statistic_temperature_normal_count = 1       
                  @statistic_temperature_cold = 0
									@statistic_temperature_cold_count = 1        
                  @statistic_weather_normal = 0
									@statistic_weather_normal_count = 1            
                  @statistic_weather_wind = 0
									@statistic_weather_wind_count = 1           
                  @statistic_weather_rain = 0 
									@statistic_weather_rain_count = 1
                  @statistic_weather_wind_and_rain = 0
									@statistic_weather_wind_and_rain_count = 1            
                  @statistic_trajectory_normal = 0 
									@statistic_trajectory_normal_count = 1        
                  @statistic_trajectory_high = 0
									@statistic_trajectory_high_count = 1            
                  @statistic_trajectory_low = 0
									@statistic_trajectory_low_count = 1          
                  @statistic_trajectory_drow = 0
									@statistic_trajectory_drow_count = 1          
                  @statistic_trajectory_hook = 0 
									@statistic_trajectory_hook_count = 1  
                  @statistic_trajectory_fade = 0
									@statistic_trajectory_fade_count = 1    
                  @statistic_trajectory_slice = 0
									@statistic_trajectory_slice_count = 1            
                  @statistic_green_direction_straight = 0
									@statistic_green_direction_straight_count = 1                
                  @statistic_green_direction_upward_right = 0
									@statistic_green_direction_upward_right_count = 1            
                  @statistic_green_direction_upward_left = 0
									@statistic_green_direction_upward_left_count = 1          
                  @statistic_green_direction_downward_right = 0
									@statistic_green_direction_downward_right_count = 1           
                  @statistic_green_direction_downward_left = 0
									@statistic_green_direction_downward_left_count = 1      
                  @statistic_green_direction_upward_straight = 0
									@statistic_green_direction_upward_straight_count = 1              
                  @statistic_green_direction_downward_straight = 0
									@statistic_green_direction_downward_straight_count = 1  
									@statistic_green_trajectory_straight = 0
									@statistic_green_trajectory_straight_count = 1                
                  @statistic_green_trajectory_upward_right = 0
									@statistic_green_trajectory_upward_right_count = 1            
                  @statistic_green_trajectory_upward_left = 0
									@statistic_green_trajectory_upward_left_count = 1          
                  @statistic_green_trajectory_downward_right = 0
									@statistic_green_trajectory_downward_right_count = 1           
                  @statistic_green_trajectory_downward_left = 0
									@statistic_green_trajectory_downward_left_count = 1      
                  @statistic_green_trajectory_upward_straight = 0
									@statistic_green_trajectory_upward_straight_count = 1              
                  @statistic_green_trajectory_downward_straight = 0
									@statistic_green_trajectory_downward_straight_count = 1     
              		
         # continue!
			
			      #statistic.game_id = c_game.id
            #statistic.field_id = c_field.id
						@all_pairs = PairHit.where(:user_id => c_user.id).includes([:hit_planed, :hit_real])
						
            #CALCULATE PLACE_FROM
            # ==========================================
            for place_from_num in 1..11 do
           
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.place_from == place_from_num && each_pair.hit_planed.stick_id == user_stick.stick_id 
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
                end
              end

              case place_from_num
              when 1
                if @result_arr.size != 0                  
									@statistic_place_teebox += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_place_teebox_count += @result_arr.size
                end
              when 2
                if @result_arr.size != 0
                  @statistic_place_feairway += @result_arr.inject(0.0) { |sum, el| sum + el }
									 @statistic_place_feairway_count += @result_arr.size               
								end
              when 3
                if @result_arr.size != 0
                  @statistic_place_next_fairway += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_place_next_fairway_count += @result_arr.size
                end
              when 4
                if @result_arr.size != 0
                  @statistic_place_semi_raf += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_place_semi_raf_count += @result_arr.size
                end
              when 5
                if @result_arr.size != 0
                  @statistic_place_raf += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_place_raf_count += @result_arr.size
                end
              when 6
                if @result_arr.size != 0
                  @statistic_place_for_green += @result_arr.inject(0.0) { |sum, el| sum + el } 
									@statistic_place_for_green_count += @result_arr.size
                end
              when 7
                if @result_arr.size != 0
                  @statistic_place_green += @result_arr.inject(0.0) { |sum, el| sum + el } 
									@statistic_place_green_count += @result_arr.size
                end
              when 8
                if @result_arr.size != 0
                  @statistic_place_fairway_sand += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_place_fairway_sand_count += @result_arr.size
                end
              when 9
                if @result_arr.size != 0
                  @statistic_place_green_sand += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_place_green_sand_count += @result_arr.size
                end
              when 11
                if @result_arr.size != 0
                  @statistic_place_wood += @result_arr.inject(0.0) { |sum, el| sum + el } 
									@statistic_place_wood_count += @result_arr.size			
                end
              when 11
                if @result_arr.size != 0
                  @statistic_place_from_water += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_place_from_water_count += @result_arr.size
                end
              end
            end
            # ==========================================
        
        
            #CALCULATE STANCE
            # ==========================================
            for stance_num in 1..5 do
              
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.stance == stance_num && each_pair.hit_planed.stick_id == user_stick.stick_id 
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
                end
              end

              case stance_num
              when 1
                if @result_arr.size != 0
                  @statistic_stance_normal += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_stance_normal_count += @result_arr.size
                end
              when 2
                if @result_arr.size != 0
                  @statistic_stance_right_leg_lower += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_stance_right_leg_lower_count += @result_arr.size
                end
              when 3
                if @result_arr.size != 0
                  @statistic_stance_left_leg_lower += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_stance_right_leg_lower_count += @result_arr.size
                end
              when 4
                if @result_arr.size != 0
                  @statistic_stance_ball_lower += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_stance_ball_lower_count += @result_arr.size
                end
              when 5
                if @result_arr.size != 0
                  @statistic_stance_ball_higher += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_stance_ball_higher_count += @result_arr.size
                end
              end
            end
            # ==========================================
        
    
        
        
            #CALCULATE TEMPERATURE
            # ==========================================
            for temperature_num in 1..3 do
              
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.game.temperature == temperature_num && each_pair.hit_planed.stick_id == user_stick.stick_id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
                end
              end

              case temperature_num
              when 1
                if @result_arr.size != 0
                  @statistic_temperature_hot += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_temperature_hot_count += @result_arr.size
                end
              when 2
                if @result_arr.size != 0
                  @statistic_temperature_normal += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_temperature_normal_count += @result_arr.size
                end
              when 3
                if @result_arr.size != 0
                  @statistic_temperature_cold += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_temperature_cold_count += @result_arr.size
                end
              end
            end
            # ==========================================
        
        
            #CALCULATE WEATHER
            # ==========================================
            for weather_num in 1..4 do
              
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.game.weather == weather_num && each_pair.hit_planed.stick_id == user_stick.stick_id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
                end
              end

              case weather_num
              when 1
                if @result_arr.size != 0
                  @statistic_weather_normal += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_weather_normal_count += @result_arr.size
                end
              when 2
                if @result_arr.size != 0
                  @statistic_weather_wind += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_weather_wind_count += @result_arr.size
                end
              when 3
                if @result_arr.size != 0
                  @statistic_weather_rain += @result_arr.inject(0.0) { |sum, el| sum + el } 
									@statistic_weather_rain_count += @result_arr.size
                end
              when 4
                if @result_arr.size != 0
                  @statistic_weather_wind_and_rain += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_weather_wind_and_rain_count += @result_arr.size
                end
              end
            end
            # ==========================================
        
            #CALCULATE TRAJECTORY
            # ==========================================
            for trajectory_num in 1..10 do
              
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.trajectory == trajectory_num && each_pair.hit_planed.stick_id == user_stick.stick_id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
                end
              end

              case trajectory_num
              when 5
                unless @result_arr.size == 0
                  @statistic_trajectory_normal += @result_arr.inject(0.0) { |sum, el| sum + el } unless false
									@statistic_trajectory_normal_count += @result_arr.size
                end
              when 10
                if @result_arr.size != 0
                  @statistic_trajectory_high += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_trajectory_high_count += @result_arr.size
                end
              when 9
                if @result_arr.size != 0
                  @statistic_trajectory_low += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_trajectory_low_count += @result_arr.size
                end
              when 3
                if @result_arr.size != 0
                  @statistic_trajectory_drow += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_trajectory_drow_count += @result_arr.size
                end
              when 1
                if @result_arr.size != 0
                  @statistic_trajectory_hook += @result_arr.inject(0.0) { |sum, el| sum + el } 
									@statistic_trajectory_hook_count += @result_arr.size
                end
              when 4
                if @result_arr.size != 0
                  @statistic_trajectory_fade += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_trajectory_fade_count += @result_arr.size
                end
              when 2
                if @result_arr.size != 0
                  @statistic_trajectory_slice += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_trajectory_slice_count += @result_arr.size 
                end
							when 12
                if @result_arr.size != 0
                  @statistic_green_trajectory_upward_right += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_trajectory_upward_right_count += @result_arr.size
                end
              when 13
                if @result_arr.size != 0
                  @statistic_green_trajectory_downward_right += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_trajectory_downward_right_count += @result_arr.size
                end
              when 14
                if @result_arr.size != 0
                  @statistic_green_trajectory_upward_left += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_trajectory_upward_left_count += @result_arr.size
                end
              when 15
                if @result_arr.size != 0
                  @statistic_green_trajectory_downward_left += @result_arr.inject(0.0) { |sum, el| sum + el } 
									@statistic_green_trajectory_downward_left_count += @result_arr.size
                end
              when 16
                if @result_arr.size != 0
                  @statistic_green_trajectory_upward_straight += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_trajectory_upwrads_straight_count += @result_arr.size
                end

							when 17
                if @result_arr.size != 0
                  @statistic_green_trajectory_downward_straight += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_trajectory_downward_straight_count += @result_arr.size
                end
							when 18
                if @result_arr.size != 0
                  @statistic_green_trajectory_straight += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_trajectory_straight_count += @result_arr.size
                end
  

              end
            end
            # ==========================================
        
       


            #green_direction
            # ==========================================
            for direction_num in 1..12 do
              

              @result_arr = []


              @all_pairs.each do |each_pair|
                if  each_pair.hit_planed.stick_id == user_stick.stick_id &&
                    (each_pair.hit_planed.place_from == 1 || each_pair.hit_planed.place_from == 7) && each_pair.hit_planed.slipums == direction_num

                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
                end
              end
              case direction_num
              when 6
                if @result_arr.size != 0
                  @statistic_green_direction_upward_straight += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_direction_upward_straight_count += @result_arr.size
                end
              when 2
                if @result_arr.size != 0
                  @statistic_green_direction_upward_right += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_direction_upward_right_count += @result_arr.size
                end
              when 4
                if @result_arr.size != 0
                  @statistic_green_direction_upward_left += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_direction_upward_left_count += @result_arr.size
                end
              when 3
                if @result_arr.size != 0
                  @statistic_green_direction_downward_right += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_direction_downward_right_count += @result_arr.size
                end
              when 5
                if @result_arr.size != 0
                  @statistic_green_direction_downward_left += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_direction_downward_left_count += @result_arr.size
                end
              when 7
                if @result_arr.size != 0
                  @statistic_green_direction_downward_straight += @result_arr.inject(0.0) { |sum, el| sum + el }
									@statistic_green_direction_downward_straight_count += @result_arr.size
                end
              when 1
                if @result_arr.size != 0
                  @statistic_green_direction_straight += @result_arr.inject(0.0) { |sum, el| sum + el }
									 @statistic_green_direction_straight_count += @result_arr.size
                end
              end
            end
            # ==========================================



           




           # @return = true if statistic.save
           # end game
         # ends field

				#calculating average statistics per situation
				statistic.green_direction_downward_right = calculate_avg(@statistic_green_direction_downward_right, @statistic_green_direction_downward_right_count)
				statistic.green_direction_upward_right = calculate_avg(@statistic_green_direction_upward_right, @statistic_green_direction_upward_right_count)
				statistic.green_direction_downward_straight = calculate_avg(@statistic_green_direction_downward_straight, @statistic_green_direction_downward_straight_count)
				statistic.green_direction_downward_left = calculate_avg(@statistic_green_direction_downward_left, @statistic_green_direction_downward_left_count)
				statistic.green_direction_upward_left = calculate_avg(@statistic_green_direction_upward_left, @statistic_green_direction_upward_left_count)
				statistic.green_direction_upward_straight = calculate_avg(@statistic_green_direction_upward_straight, @statistic_green_direction_upward_straight_count)
				statistic.green_direction_straight = calculate_avg(@statistic_green_direction_straight, @statistic_green_direction_straight_count)

				statistic.trajectory_slice = calculate_avg(@statistic_trajectory_slice, @statistic_trajectory_slice_count)
				statistic.trajectory_drow = calculate_avg(@statistic_trajectory_drow, @statistic_trajectory_drow_count)
				statistic.trajectory_hook = calculate_avg(@statistic_trajectory_hook, @statistic_trajectory_hook_count)
				statistic.trajectory_normal = calculate_avg(@statistic_trajectory_normal, @statistic_trajectory_normal_count)
				statistic.trajectory_high = calculate_avg(@statistic_trajectory_high, @statistic_trajectory_high_count)
				statistic.trajectory_low = calculate_avg(@statistic_trajectory_low, @statistic_trajectory_low_count)
				statistic.trajectory_fade = calculate_avg(@statistic_trajectory_fade, @statistic_trajectory_fade_count)
				statistic.green_trajectory_straight = calculate_avg(@statistic_green_trajectory_straight, @statistic_green_trajectory_straight_count)
statistic.green_trajectory_upward_straight = calculate_avg(@statistic_green_trajectory_upward_straight, @statistic_green_trajectory_upward_straight_count)
statistic.green_trajectory_upward_left = calculate_avg(@statistic_green_trajectory_upward_left, @statistic_green_trajectory_upward_left_count)
statistic.green_trajectory_upward_right = calculate_avg(@statistic_green_trajectory_upward_right, @statistic_green_trajectory_upward_right_count)
statistic.green_trajectory_downward_straight = calculate_avg(@statistic_green_trajectory_downward_straight, @statistic_green_trajectory_downward_straight_count)
statistic.green_trajectory_downward_left = calculate_avg(@statistic_green_trajectory_downward_left, @statistic_green_trajectory_downward_left_count)
statistic.green_trajectory_downward_right = calculate_avg(@statistic_green_trajectory_downward_right, @statistic_green_trajectory_downward_right_count)


				statistic.weather_wind_and_rain = calculate_avg(@statistic_weather_wind_and_rain, @statistic_weather_wind_and_rain_count)
				statistic.weather_wind = calculate_avg(@statistic_weather_wind, @statistic_weather_wind_count)
				statistic.weather_rain = calculate_avg(@statistic_weather_rain, @statistic_weather_rain_count)
				statistic.weather_normal = calculate_avg(@statistic_weather_normal, @statistic_weather_normal_count)

				statistic.temperature_cold = calculate_avg(@statistic_temperature_cold, @statistic_temperature_cold_count)
				statistic.temperature_normal = calculate_avg(@statistic_temperature_normal, @statistic_temperature_normal_count)
				statistic.temperature_hot = calculate_avg(@statistic_temperature_hot, @statistic_temperature_hot_count)

				statistic.stance_ball_higher = calculate_avg(@statistic_stance_ball_higher, @statistic_stance_ball_higher_count)
				statistic.stance_ball_lower = calculate_avg(@statistic_stance_ball_lower, @statistic_stance_ball_lower_count)
				statistic.stance_left_leg_lower = calculate_avg(@statistic_stance_left_leg_lower, @statistic_stance_left_leg_lower_count)
				statistic.stance_right_leg_lower = calculate_avg(@statistic_stance_right_leg_lower, @statistic_stance_right_leg_lower_count)
				statistic.stance_normal = calculate_avg(@statistic_stance_normal, @statistic_stance_normal_count) 

				statistic.place_teebox = calculate_avg(@statistic_place_teebox, @statistic_place_teebox_count) 
			  statistic.place_feairway = calculate_avg(@statistic_place_feairway, @statistic_place_feairway_count)
			  statistic.place_next_fairway = calculate_avg(@statistic_place_next_fairway, @statistic_place_next_fairway_count)
			  statistic.place_semi_raf = calculate_avg(@statistic_place_semi_raf, @statistic_place_semi_raf_count) 
			  statistic.place_raf = calculate_avg(@statistic_place_raf, @statistic_place_raf_count)
			  statistic.place_for_green = calculate_avg(@statistic_place_for_green, @statistic_place_for_green_count)
			  statistic.place_green = calculate_avg(@statistic_place_green, @statistic_place_green_count)
			  statistic.place_fairway_sand = calculate_avg(@statistic_place_fairway_sand, @statistic_place_fairway_sand_count)
		    statistic.place_green_sand = calculate_avg(@statistic_place_green_sand, @statistic_place_green_sand_count) 
		    statistic.place_wood = calculate_avg(@statistic_place_wood, @statistic_place_wood_count)
		    statistic.place_from_water = calculate_avg(@statistic_place_from_water, @statistic_place_from_water_count)
				statistic.update_attributes(:calculated => true)
				statistic.save!
				Statistic.all_stick_statistics(statistic, c_user)	
				Statistic.user_progres(statistic)			
				SingleFieldStatistic.calculate_stats(c_user)
			 end
      end # end stick
    end # end user
   
    return true
  end
  

def self.calculate_avg(total_sum, total_count)
	if total_count == nil 
	 	percentage = 1
	else	 
		percentage = total_sum.to_f / total_count.to_f
	end	
	if percentage < 1  
	 percentage = 0
	elsif percentage > 100
		percentage = 100
	else
	puts percentage.round
	 return percentage.round.to_i		
  end		
end

  #================================================
  # Game statistics
  def self.game_filter_statistic(user_id, place_from, stance, temperature, trajectory, field_id, weather)
		@games = Game.where('games.user_id = ? AND games.temperature IN(?) AND games.field_id = ? AND games.weather IN(?)', user_id, temperature, field_id, weather)
		@game_id_arr = []
		if @games.count != 0 
			@games.each {|game| @game_id_arr << game.id }
		
			@pair_hits = PairHit.where('pair_hits.game_id IN(?)', @game_id_arr).joins('INNER JOIN hits ON hits.id = pair_hits.hit_planed_id').where('hits.place_from IN(?) AND hits.stance IN(?) AND hits.trajectory IN(?)', place_from, stance, trajectory)

			@result_arr = []
      @result_sum = 0  
  	  @pair_hits.each do |each_pair|
  	     @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
				 puts @add_to_arr
  	     @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
			end
			if @result_arr.size != 0
			 	@result_arr.each {|element| @result_sum += element}
			 	@final_result = calculate_avg(@result_sum, @result_arr.size)
			else
			 @final_result = false
			end
		else 
			@final_result = false
		end
		return @final_result

  end

	  

  def self.game_statistics_general

    GameStatisticGeneral.delete_all
    @return = false

    User.all.each do |c_user|
      Game.where(:user_id => c_user.id).each do |c_game|
      
        @Statistic = Statistic.where(:user_id => c_user.id, :game_id => c_game.id)
        @user_progres_arr = []

        @Statistic.each do |c_stat|
          @user_progres_arr.push(c_stat.place_teebox) unless c_stat.place_teebox == nil
          @user_progres_arr.push(c_stat.place_feairway) unless c_stat.place_feairway == nil
          @user_progres_arr.push(c_stat.place_next_fairway) unless c_stat.place_next_fairway == nil
          @user_progres_arr.push(c_stat.place_semi_raf) unless c_stat.place_semi_raf == nil
          @user_progres_arr.push(c_stat.place_raf) unless c_stat.place_raf == nil
          @user_progres_arr.push(c_stat.place_for_green) unless c_stat.place_for_green == nil
          @user_progres_arr.push(c_stat.place_green) unless c_stat.place_green == nil
          @user_progres_arr.push(c_stat.place_fairway_sand) unless c_stat.place_fairway_sand == nil
          @user_progres_arr.push(c_stat.place_green_sand) unless c_stat.place_green_sand == nil
          @user_progres_arr.push(c_stat.place_wood) unless c_stat.place_wood == nil
          @user_progres_arr.push(c_stat.place_from_water) unless c_stat.place_from_water == nil

          @user_progres_arr.push(c_stat.stance_normal) unless c_stat.stance_normal == nil
          @user_progres_arr.push(c_stat.stance_right_leg_lower) unless c_stat.stance_right_leg_lower == nil
          @user_progres_arr.push(c_stat.stance_left_leg_lower) unless c_stat.stance_left_leg_lower == nil
          @user_progres_arr.push(c_stat.stance_ball_lower) unless c_stat.stance_ball_lower == nil
          @user_progres_arr.push(c_stat.stance_ball_higher) unless c_stat.stance_ball_higher == nil

          @user_progres_arr.push(c_stat.temperature_cold) unless c_stat.temperature_cold == nil
          @user_progres_arr.push(c_stat.temperature_normal) unless c_stat.temperature_normal == nil
          @user_progres_arr.push(c_stat.temperature_hot) unless c_stat.temperature_hot == nil

          @user_progres_arr.push(c_stat.weather_normal) unless c_stat.weather_normal == nil
          @user_progres_arr.push(c_stat.weather_wind) unless c_stat.weather_wind == nil
          @user_progres_arr.push(c_stat.weather_rain) unless c_stat.weather_rain == nil
          @user_progres_arr.push(c_stat.weather_wind_and_rain) unless c_stat.weather_wind_and_rain == nil

          @user_progres_arr.push(c_stat.trajectory_normal) unless c_stat.trajectory_normal == nil
          @user_progres_arr.push(c_stat.trajectory_high) unless c_stat.trajectory_high == nil
          @user_progres_arr.push(c_stat.trajectory_low) unless c_stat.trajectory_low == nil
          @user_progres_arr.push(c_stat.trajectory_hook) unless c_stat.trajectory_hook == nil
          @user_progres_arr.push(c_stat.trajectory_slice) unless c_stat.trajectory_slice == nil
          @user_progres_arr.push(c_stat.trajectory_drow) unless c_stat.trajectory_drow == nil
          @user_progres_arr.push(c_stat.trajectory_fade) unless c_stat.trajectory_fade == nil


        end # end statistic

        @GameStatisticsGeneral = GameStatisticGeneral.new
        @global_hits = Hit.where(:game_id => c_game.id)

        @GameStatisticsGeneral.game_id = c_game.id
        @GameStatisticsGeneral.hit_sum = @global_hits.count #hit_sum
        @GameStatisticsGeneral.put_sum = @global_hits.where(:place_from => 1).count #put_sum
        @GameStatisticsGeneral.gir_sum = @global_hits.where(:land_place => 1, :hit_number => 1).count #gir_sum



        @user_stats_progres_val = (@user_progres_arr.inject(0.0) { |sum, el| sum + el } / @user_progres_arr.size).round unless @user_progres_arr.size == 0
        @GameStatisticsGeneral.game_progress = @user_stats_progres_val


        @return = true if @GameStatisticsGeneral.save

      end # end game
    end # end user
    
   

    return @return
  end
  
  
  def self.all_stick_statistics(statistic, user)
        @AllStickStatistics = AllStickStatistic.find_or_create_by_user_id_and_stick_id(user.id, statistic.stick_id)
        	@all_c_hits = user.hits.where(:stick_id => statistic.stick_id, :real_hit => ['rp', 'penalty_r'])
    	    @AllStickStatistics.avg_distance = @all_c_hits.average("hit_distance")
					@all_hits = user.hits
    			unless @all_hits.count == 0 || @all_c_hits.count == 0
       	 	  @AllStickStatistics.usage = (((@all_c_hits.count).to_f / (@all_hits.count).to_f).to_f * 100).round
       	 	end

        	result_arr = []					
        	statistic.attributes.each_pair do |name, value|
						if value.class.to_s == "Fixnum"
							if name.to_s != "id" || name.to_s != "game_id" || name.to_s != "field_id" || name.to_s != "user_id" || name.to_s != "stick_id" 
        	     result_arr << value.to_i if value.to_i > 0 && value != nil
							end
        	  end
       	 	end
       	 if result_arr.size == 0
          @AllStickStatistics.stick_progres = 0
        	else
						sum = 0
						result_arr.each {|arr| sum += arr.to_i }
        	  @AllStickStatistics.stick_progres = calculate_avg(sum, @result_arr.size)
       	 end

      	 @AllStickStatistics.save!
    return @return
  end

  
  
  def self.check_golf_club_pay_banner_time_limit
    @return = true
      
    @golf_clubs = GolfClub.all
      
    @golf_clubs.each do |c_club|
      unless c_club.pay_banner_end_date == nil
        @DateNow = Date.today #Date.new(Time.now.month, Time.now.day, Time.now.year)
        puts "----------------------"
        puts "dates"
        puts @DateNow
        puts "day #{@DateNow.day}"
        puts "month #{@DateNow.month}"
        puts "year #{@DateNow.year}"
        
        c_club.update_attributes(:is_p_banner_disabled => true) if (c_club.pay_banner_end_date < @DateNow) && c_club.is_p_banner_disabled == false
      end
    end

    return @return
  end

  def self.user_progres(statistic)
        
        @user_progres_arr = []
        
          @user_progres_arr.push(statistic.place_teebox) unless statistic.place_teebox == nil
          @user_progres_arr.push(statistic.place_feairway) unless statistic.place_feairway == nil
          @user_progres_arr.push(statistic.place_next_fairway) unless statistic.place_next_fairway == nil
          @user_progres_arr.push(statistic.place_semi_raf) unless statistic.place_semi_raf == nil
          @user_progres_arr.push(statistic.place_raf) unless statistic.place_raf == nil
          @user_progres_arr.push(statistic.place_for_green) unless statistic.place_for_green == nil
          @user_progres_arr.push(statistic.place_green) unless statistic.place_green == nil
          @user_progres_arr.push(statistic.place_fairway_sand) unless statistic.place_fairway_sand == nil
          @user_progres_arr.push(statistic.place_green_sand) unless statistic.place_green_sand == nil
          @user_progres_arr.push(statistic.place_wood) unless statistic.place_wood == nil
          @user_progres_arr.push(statistic.place_from_water) unless statistic.place_from_water == nil

          @user_progres_arr.push(statistic.stance_normal) unless statistic.stance_normal == nil
          @user_progres_arr.push(statistic.stance_right_leg_lower) unless statistic.stance_right_leg_lower == nil
          @user_progres_arr.push(statistic.stance_left_leg_lower) unless statistic.stance_left_leg_lower == nil
          @user_progres_arr.push(statistic.stance_ball_lower) unless statistic.stance_ball_lower == nil
          @user_progres_arr.push(statistic.stance_ball_higher) unless statistic.stance_ball_higher == nil

       
          @user_progres_arr.push(statistic.temperature_cold) unless statistic.temperature_cold == nil
          @user_progres_arr.push(statistic.temperature_normal) unless statistic.temperature_normal == nil
          @user_progres_arr.push(statistic.temperature_hot) unless statistic.temperature_hot == nil

          @user_progres_arr.push(statistic.weather_normal) unless statistic.weather_normal == nil
          @user_progres_arr.push(statistic.weather_wind) unless statistic.weather_wind == nil
          @user_progres_arr.push(statistic.weather_rain) unless statistic.weather_rain == nil
          @user_progres_arr.push(statistic.weather_wind_and_rain) unless statistic.weather_wind_and_rain == nil

          @user_progres_arr.push(statistic.trajectory_normal) unless statistic.trajectory_normal == nil
          @user_progres_arr.push(statistic.trajectory_high) unless statistic.trajectory_high == nil
          @user_progres_arr.push(statistic.trajectory_low) unless statistic.trajectory_low == nil
          @user_progres_arr.push(statistic.trajectory_drow) unless statistic.trajectory_drow == nil
          @user_progres_arr.push(statistic.trajectory_hook) unless statistic.trajectory_hook == nil
          @user_progres_arr.push(statistic.trajectory_slice) unless statistic.trajectory_slice == nil
          @user_progres_arr.push(statistic.trajectory_fade) unless statistic.trajectory_fade == nil

        
        unless @user_progres_arr.size == 0
          @user_stats_progres_val = (@user_progres_arr.inject(0.0) { |sum, el| sum + el } / @user_progres_arr.size).round

          @u_stats_prog = StatisticUserProgres.find_or_create_by_user_id(statistic.user_id)
          @u_stats_prog.user_progress = @user_stats_progres_val
          @u_stats_prog.user_id = statistic.user_id
          @u_stats_prog.hcp = statistic.user.hcp

          @max_dist = Hit.where("real_hit = 'r' OR real_hit = 'rp'").where(:user_id => statistic.user_id).order("hit_distance DESC").first

          @u_stats_prog.max_distance = @max_dist.hit_distance
          @return = true if @u_stats_prog.save
        end
    @all_user_progress = StatisticUserProgres.order("user_progress")
    @num = 1

    @all_user_progress.each do |c_u_progr|
      @c = StatisticUserProgres.find(c_u_progr.id)
      @c.num = @num
      @c.save
      @num = @num + 1
    end

    return @return
  end

end
