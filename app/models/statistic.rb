class Statistic < ActiveRecord::Base
  has_many    :users
  has_many    :hits
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
    p = planed.hit_distance
    r = real.hit_distance
    
    unless p == nil or r == nil
      @result = ((1 - ((r.to_f - p.to_f).abs / p.to_f)).round(2) * 100).round
       
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

    @return = false
    
    3.times { puts "============================================xx" }
  
    Statistic.delete_all
    @users = User.where(:is_super_admin => false)
    @users.each do |user|
      user.users_sticks.each do |user_stick|
        
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
              statistic.place_teebox = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 2
            if @result_arr.size != 0
              statistic.place_feairway = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 3
            if @result_arr.size != 0
              statistic.place_next_fairway = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 4
            if @result_arr.size != 0
              statistic.place_semi_raf = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 5
            if @result_arr.size != 0
              statistic.place_raf = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 6
            if @result_arr.size != 0
              statistic.place_for_green = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 7
            if @result_arr.size != 0
              statistic.place_green = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 8
            if @result_arr.size != 0
              statistic.place_fairway_sand = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 9
            if @result_arr.size != 0
              statistic.place_green_sand = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 11
            if @result_arr.size != 0
              statistic.place_wood = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 11
            if @result_arr.size != 0
              statistic.place_from_water = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
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
              statistic.stance_normal = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 2
            if @result_arr.size != 0
              statistic.stance_right_leg_lower = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 3
            if @result_arr.size != 0
              statistic.stance_left_leg_lower = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 4
            if @result_arr.size != 0
              statistic.stance_ball_lower = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 5
            if @result_arr.size != 0
              statistic.stance_ball_higher = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
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
              statistic.direction_straigth = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 2
            if @result_arr.size != 0
              statistic.direction_fade = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 3
            if @result_arr.size != 0
              statistic.direction_drow = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 4
            if @result_arr.size != 0
              statistic.direction_slice = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 5
            if @result_arr.size != 0
              statistic.direction_hook = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
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
              statistic.temperature_hot = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 2
            if @result_arr.size != 0
              statistic.temperature_normal = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 3
            if @result_arr.size != 0
              statistic.temperature_cold = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
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
              statistic.weather_normal = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 2
            if @result_arr.size != 0
              statistic.weather_wind = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 3
            if @result_arr.size != 0
              statistic.weather_rain = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 4
            if @result_arr.size != 0
              statistic.weather_wind_and_rain = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
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
              statistic.trajectory_normal = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round unless false
            end
          when 2
            if @result_arr.size != 0
              statistic.trajectory_high = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 3
            if @result_arr.size != 0
              statistic.trajectory_low = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
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
              statistic.wind_from_behind = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 2
            if @result_arr.size != 0
              statistic.wind_from_front = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          when 3
            if @result_arr.size != 0
              statistic.wind_from_right
            end
          when 4
            if @result_arr.size != 0
              statistic.wind_from_right = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
            end
          end
        end
        # ==========================================
      
        @return = true if statistic.save
      end
    end
   
    return @return
  end
  

  #================================================
  # Game statistic
  
  def self.game_statistics_by_holes
    GameStatisticsByHoles.delete_all
    @return = false
    
    @games = Game.all
    @games.each do |c_game|
      
      @holes = Hole.where(:field_id => c_game.field_id)
      @holes.each do |c_hole|
       
        @hits = Hit.where(
          :game_id => c_game.id, 
          :user_id => c_game.user_id,
          :hole_id => c_hole.id)
        
        game_s_holes = GameStatisticsByHoles.new
        game_s_holes.game_id = c_game.id #game_id
        game_s_holes.user_id = c_game.user_id #user_id
        game_s_holes.field_id = c_game.field_id #field_id
        
        game_s_holes.hole_id = c_hole.id #hole_id
        game_s_holes.hole_number = c_hole.hole_number #hole_number
        
        @hit_p = @hits.where("real_hit = 'p' OR real_hit = 'pp'").order("hit_number ASC")
        @hit_r = @hits.where("real_hit = 'r' OR real_hit = 'rp'").order("hit_number ASC")
        
        game_s_holes.puts_p = @hit_p.where(:place_from => 1).count
        game_s_holes.puts_r = @hit_r.where(:place_from => 1).count
        
        game_s_holes.hit_p = @hit_p.count
        game_s_holes.hit_r = @hit_r.count
        
        @stick_order_p_arr = []
        @stick_order_r_arr = []
        
        @hit_p.each do |c_p_hit|
          @stick_order_p_arr.push(Stick.find(c_p_hit.stick).short_name)
        end
        
        @hit_r.each do |c_r_hit|
          @stick_order_r_arr.push(Stick.find(c_r_hit.stick_id).short_name)
        end
        
        game_s_holes.stick_order_p = @stick_order_p_arr.join(", ") unless @stick_order_p_arr.length == 0
        game_s_holes.stick_order_r = @stick_order_r_arr.join(", ") unless @stick_order_r_arr.length == 0
        
        @return = true if game_s_holes.save
      end # ends hole
    end # ends game
    
    return @return
  end
  
  
  def self.game_statistics_by_sticks
    GameStatisticsBySticks.delete_all
    @return = false
    
    @games = Game.all
    @games.each do |c_game|
      
      @user = c_game.user
      @user_sticks = UsersStick.where(:user_id => @user.id)
      @user_sticks.each do |c_user_stick|
      
        game_s_sticks = GameStatisticsBySticks.new
        game_s_sticks.game_id = c_game.id
        game_s_sticks.fields_id = c_game.field_id
        game_s_sticks.users_stick_id = c_user_stick.id
        game_s_sticks.user_id = @user.id
        @hit_p = Hit.where("real_hit = 'p' OR real_hit = 'pp'").where(:stick_id => c_user_stick.stick.id, :game_id => c_game.id).order("hit_number ASC")
        @hit_r = Hit.where("real_hit = 'r' OR real_hit = 'rp'").where(:stick_id => c_user_stick.stick.id, :game_id => c_game.id).order("hit_number ASC")
        
        game_s_sticks.hits_p = @hit_p.count
        game_s_sticks.hits_r = @hit_r.count
        
        @all_hits = Hit.all
        @all_current_stick_hits = Hit.where(:stick_id => c_user_stick.stick.id)
        @avg = ((@all_current_stick_hits.count.to_f / @all_hits.count.to_f).to_f * 100).round
        game_s_sticks.stick_usage = @avg
        game_s_sticks.avg_distance = @all_current_stick_hits.average("hit_distance") #@all_current_stick_hits.count
        
        @return = true if game_s_sticks.save
        
      end # ends user stick
    end # ends game
    
    return @return
  end
    
  def self.game_statistics_general
    GameStatisticsGeneral.delete_all
    @return = false
    
    @games = Game.all
    @games.each do |c_game|
      @GameStatisticsGeneral = GameStatisticsGeneral.new
      @global_hits = Hit.where(:game == c_game.id)
      
      @GameStatisticsGeneral.game_id = c_game.id
      game_s_holes.hit_sum = @global_hits.count #hit_sum
      game_s_holes.put_sum = @global_hits.where(:place_from => 1).count #put_sum
      game_s_holes.gir_sum = @global_hits.where(:land_place => 1, :hit_number => 1).count #gir_sum
      @return = true if @GameStatisticsGeneral.save
    end
    return @return
  end
  
  
  def self.all_sticks_statistics
    AllStickStatistics.delete_all
    
    @return = false
    
    @users = User.all      
    @users.each do |c_user|
     
      c_user.users_stick.each do |c_users_stick|
    
        @AllStickStatistics = AllStickStatistics.new
        
        @all_hits = Hit.all
        @all_c_hits = Hit.where(:stick_id => c_users_stick.stick.id)

        @AllStickStatistics.user_id = c_user.id
        @AllStickStatistics.stick_id = c_users_stick.stick.id
        @AllStickStatistics.stick_usage = ((@all_c_hits.count.to_f / @all_hits.count.to_f).to_f * 100).round
        @AllStickStatistics.avg_distance = @all_c_hits.average("hit_distance") #@all_current_stick_hits.count
        
        @stick_progres_arr = []
        
        @current_users_stick_stats = Statistic.where(:user_stick_id => c_users_stick)
        
        @current_users_stick_stats.each do |sss|
          @stick_progres_arr.push(sss)
        end
        
        @AllStickStatistics.stick_progres = (@stick_progres_arr.inject(0.0) { |sum, el| sum + el } / @stick_progres_arr.size).round
        
        
        @return = true if @AllStickStatistics.save
      end # ends user stick
    end
    
    return @return
  end
  
  
  
  def self.check_golf_club_pay_banner_time_limit
    @return = true
    
    @golf_clubs = GolfClub.all
    @time = Time.now
    
    @golf_clubs.each do |golf_club|
      if golf_club.pay_banner_end_date > @time
        c_club = GolfClub.find(golf_club.id)
        c_club.is_banner_active = false
        @return = false unless c_club.save 
      end
    end
    
    return @return
  end
end