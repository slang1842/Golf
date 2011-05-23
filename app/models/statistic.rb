class Statistic < ActiveRecord::Base
  has_many  :users
  has_many  :hits
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
    p = planed.hit_distance
    r = real.hit_distance
    
    unless p == nil or r == nil
      @result = ((1 - ((r.to_f - p.to_f).abs / p.to_f)).round(2) * 100).to_i
       
      @result = @result - calculate_diference(planed.trajectory, real.trajectory) unless calculate_diference(planed.trajectory, real.trajectory) == false
      @result = @result - calculate_diference(planed.hit_was, real.hit_was) unless calculate_diference(planed.hit_was, real.hit_was) == false
      @result = @result - calculate_diference(planed.motion_was, real.motion_was) unless calculate_diference(planed.motion_was, real.motion_was) == false
      @result = @result - calculate_diference(planed.misdirection, real.misdirection) unless calculate_diference(planed.misdirection, real.misdirection) == false
        
      if @result > 100
        return 100
      elsif @result < 1
        return 1
      else
        return @result
      end
    end    
  end
  
  
  def self.main_statistics

    @good = false
    
    3.times { puts "============================================xx" }
  
    Statistic.delete_all
    @users = User.where(:is_super_admin => false)
    @users.each do |user|
      puts ""
      puts "user_id #{user.id}"
      puts ""
      user.users_sticks.each do |user_stick|
        puts " stick_id #{user_stick.stick.id}"
        
        statistic = Statistic.new
        statistic.user_id = user.id
        statistic.stick_id = user_stick.stick.id
        
        #CALCULATE PLACE_FROM
        # ==========================================
        for place_from_num in 1..11 do
          @all_pairs = PairHit.where(:users_id => user.id)
          
          @result_arr = []
        
          @all_pairs.each do |each_pair|
            if each_pair.hit_planed.place_from == place_from_num && each_pair.hit_planed.stick_id == user_stick.stick.id
              @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
              @result_arr.push(@add_to_arr) unless @add_to_arr == false
            end
          end

          case place_from_num 
          when 1
            if @result_arr.size != 0
              statistic.place_teebox = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 2
            if @result_arr.size != 0
              statistic.place_feairway = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 3
            if @result_arr.size != 0
              statistic.place_next_fairway = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 4
            if @result_arr.size != 0
              statistic.place_semi_raf = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 5
            if @result_arr.size != 0
              statistic.place_raf = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 6
            if @result_arr.size != 0
              statistic.place_for_green = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 7
            if @result_arr.size != 0
              statistic.place_green = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 8
            if @result_arr.size != 0
              statistic.place_fairway_sand = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 9
            if @result_arr.size != 0
              statistic.place_green_sand = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 11
            if @result_arr.size != 0
              statistic.place_wood = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 11
            if @result_arr.size != 0
              statistic.place_from_water = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          end
        end
        # ==========================================
        
        
        #CALCULATE STANCE
        # ==========================================
        for stance_num in 1..5 do
          @all_pairs = PairHit.where(:users_id => user.id)
          
          @result_arr = []
        
          @all_pairs.each do |each_pair|
            if each_pair.hit_planed.stance == stance_num && each_pair.hit_planed.stick_id == user_stick.stick.id
              @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
              @result_arr.push(@add_to_arr) unless @add_to_arr == false
            end
          end

          case stance_num 
          when 1
            if @result_arr.size != 0
              puts "    stance: Normal: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.stance_normal = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 2
            if @result_arr.size != 0
              puts "    stance: Right leg lower: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.stance_right_leg_lower = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 3
            if @result_arr.size != 0
              puts "    stance: Left leg lower: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.stance_left_leg_lower = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 4
            if @result_arr.size != 0
              puts "    stance: Ball lower: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.stance_ball_lower = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 5
            if @result_arr.size != 0
              puts "    stance: Ball higher: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.stance_ball_higher = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          end
        end
        # ==========================================
        
        
        #CALCULATE DIRECTION
        # ==========================================
        for direction_num in 1..5 do
          @all_pairs = PairHit.where(:users_id => user.id)
          
          @result_arr = []
        
          @all_pairs.each do |each_pair|
            if each_pair.hit_planed.direction == direction_num && each_pair.hit_planed.stick_id == user_stick.stick.id
              @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
              @result_arr.push(@add_to_arr) unless @add_to_arr == false
            end
          end

          case direction_num 
          when 1
            if @result_arr.size != 0
              puts "    direction: Straigth: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.direction_straigth = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 2
            if @result_arr.size != 0
              puts "    direction: Fade: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.direction_fade = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 3
            if @result_arr.size != 0
              puts "    direction: Drow: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.direction_drow = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 4
            if @result_arr.size != 0
              puts "    direction: Slice: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.direction_slice = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 5
            if @result_arr.size != 0
              puts "    direction: Hook: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.direction_hook = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          end
        end
        # ==========================================
        
        
        #CALCULATE TEMPERATURE
        # ==========================================
        for temperature_num in 1..3 do
          @all_pairs = PairHit.where(:users_id => user.id)
          
          @result_arr = []
        
          @all_pairs.each do |each_pair|
            if each_pair.hit_planed.game.temperature == temperature_num && each_pair.hit_planed.stick_id == user_stick.stick.id
              @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
              @result_arr.push(@add_to_arr) unless @add_to_arr == false
            end
          end

          case temperature_num 
          when 1
            if @result_arr.size != 0
              puts "    temperature: Hot: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.temperature_hot = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 2
            if @result_arr.size != 0
              puts "    temperature: Normal: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.temperature_normal = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 3
            if @result_arr.size != 0
              puts "    temperature: Cold: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.temperature_cold = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          end
        end
        # ==========================================
        
        
        #CALCULATE WEATHER
        # ==========================================
        for weather_num in 1..4 do
          @all_pairs = PairHit.where(:users_id => user.id)
          
          @result_arr = []
        
          @all_pairs.each do |each_pair|
            if each_pair.hit_planed.game.weather == weather_num && each_pair.hit_planed.stick_id == user_stick.stick.id
              @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
              @result_arr.push(@add_to_arr) unless @add_to_arr == false
            end
          end

          case weather_num 
          when 1
            if @result_arr.size != 0
              puts "    weather: Normal: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.weather_normal = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 2
            if @result_arr.size != 0
              puts "    weather: Wind: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.weather_wind = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 3
            if @result_arr.size != 0
              puts "    weather: Rain: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.weather_rain = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 4
            if @result_arr.size != 0
              puts "    weather: Wind and Rain: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.weather_wind_and_rain = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          end
        end
        # ==========================================
        
        #CALCULATE TRAJECTORY
        # ==========================================
        for trajectory_num in 1..3 do
          @all_pairs = PairHit.where(:users_id => user.id)
          
          @result_arr = []
        
          @all_pairs.each do |each_pair|
            if each_pair.hit_planed.trajectory == trajectory_num && each_pair.hit_planed.stick_id == user_stick.stick.id
              @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
              @result_arr.push(@add_to_arr) unless @add_to_arr == false
            end
          end

          case trajectory_num 
          when 1
            unless @result_arr.size == 0
              statistic.trajectory_normal = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i unless false
            end
          when 2
            if @result_arr.size != 0
              statistic.trajectory_high = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 3
            if @result_arr.size != 0
              statistic.trajectory_low = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          end
        end
        # ==========================================
        
        
        #CALCULATE WIND
        # ==========================================
        for wind_num in 1..4 do
          @all_pairs = PairHit.where(:users_id => user.id)
          
          @result_arr = []
        
          @all_pairs.each do |each_pair|
            if each_pair.hit_planed.wind == wind_num && each_pair.hit_planed.stick_id == user_stick.stick.id
              @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
              @result_arr.push(@add_to_arr) unless @add_to_arr == false
            end
          end

          case wind_num 
          when 1
            if @result_arr.size != 0
              puts "    wind: From behind: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.wind_from_behind = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 2
            if @result_arr.size != 0
              puts "    wind: From front: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.wind_from_front = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 3
            if @result_arr.size != 0
              puts "    wind: From right: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.wind_from_right
            end
          when 4
            if @result_arr.size != 0
              puts "    wind: From left: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.wind_from_right = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          end
        end
        # ==========================================
        
        if statistic.save
          @good = true
        else
          @good = false
        end
      end
    end
    puts ""
    3.times { puts "============================================xx" }
  
    if @good
      return true
    else
      return false      
    end
  end
  

  #================================================
  # Game statistic
  
  def self.game_statistics_by_holes
    GameStatisticsByHoles.delete_all
    
    @games = Game.all
    @game_all_saved = true
    
    @games.each do |c_game|
      
      @user = User.find(c_game.user_id)
      @fields = Field.where(:golf_club_id == @user.golf_club_id)
      @fields.each do |c_field|
      
        
        @holes = Hole.where(:field_id == c_field.id)
        @holes.each do |c_hole|
            
          game_s_by_holes = GameStatisticsByHoles.new
          game_s_by_holes.game_id = c_game.id
          game_s_by_holes.user_id = c_game.user_id
          game_s_by_holes.field_id = c_field.id
          game_s_by_holes.hole_id = c_hole.id
          
          @all_c_hits = Hit.where(:game_id == c_game.id, :hole_id == c_hole.id)
          @all_c_hits_p = @all_c_hits.where("real_hit = 'p' OR real_hit = 'pp'", :order => "hit_number ASC")
          @all_c_hits_r = @all_c_hits.where("real_hit = 'r' OR real_hit = 'rp'", :order => "hit_number ASC")
         
          @hits_p_arr = []
          @hits_r_arr = []
          @hit_p_count = 0
          @hit_r_count = 0
          @hit_p_put_count = 0
          @hit_r_put_count = 0
          
          @all_c_hits_p.each do |p|
            @hits_p_arr.push(p.stick.short_name)
            @hit_p_count =+ 1
            if p.place_from == 1
              @hit_p_put_count =+ 1
            end
          end
          
          @all_c_hits_r.each do |r|
            @hits_r_arr.push(r.stick.short_name)
            @hit_r_count =+ 1
            if r.place_from == 1
              @hit_r_put_count =+ 1
            end
          end
          
          if game_s_by_holes.save
            @game_all_saved = true
          else
            @game_all_saved = false
          end
      
        end # ends hole
      end # ends field
    
      
      #game_s_by_holes.game_id = c_game.id
      #game_s_by_holes.user_id = c_game.user_id
      #game_s_by_holes.field_id = c_game.field.id
      
      #all planed hits
      #@hits = Hit.where(:game_id == c_game.id)
      #@hits = @hits.where("real_hit = 'p' OR real_hit = 'pp'")
      
    
      #@hit_arr = []
      #@hits.each do |c_hit|
      #  @hit_arr.push(@add_to_arr)
      #end
      
      
     
    end # ends game
    
    if @game_all_saved
      return true
    else
      return false
    end
  end
  
  def self.game_statistics_by_sticks
    @users = User.where(:is_super_admin => false)
    
    
    return true
  end
  
end