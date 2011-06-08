class Statistic < ActiveRecord::Base
  has_many    :users
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
    p = planed.hit_distance
    r = real.hit_distance
    
    unless p == nil or r == nil

      #formula ir
      #
      #              | R - P |
      # result = 1 - -------- * 100
      #                  P
      #
      
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
    Statistic.delete_all

    User.where(:is_super_admin => false).each do |c_user|

      
      #Field.where(:golf_club_id => c_user.golf_club_id).each do |c_field|

      Field.where(:golf_club_id => c_user.golf_club_id).each do |c_field|
        Game.where(:field_id => c_field.id).each do |c_game|

          c_user.users_sticks.each do |user_stick|
        
            statistic = Statistic.new
            statistic.user_id = c_user.id
            statistic.game_id = c_game.id
            statistic.field_id = c_field.id
            statistic.stick_id = user_stick.stick.id
        
            #CALCULATE PLACE_FROM
            # ==========================================
            for place_from_num in 1..11 do
              @all_pairs = PairHit.where(:user_id => c_user.id)
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.place_from == place_from_num && each_pair.hit_planed.stick_id == user_stick.stick.id && each_pair.hit_planed.game.field_id == c_field.id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
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
              @all_pairs = PairHit.where(:user_id => c_user.id)
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.stance == stance_num && each_pair.hit_planed.stick_id == user_stick.stick.id && each_pair.hit_planed.game.field_id == c_field.id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
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
              @all_pairs = PairHit.where(:user_id => c_user.id)
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.direction == direction_num && each_pair.hit_planed.stick_id == user_stick.stick.id && each_pair.hit_planed.game.field_id == c_field.id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
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
              @all_pairs = PairHit.where(:user_id => c_user.id)
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.game.temperature == temperature_num && each_pair.hit_planed.stick_id == user_stick.stick.id && each_pair.hit_planed.game.field_id == c_field.id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
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
              @all_pairs = PairHit.where(:user_id => c_user.id)
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.game.weather == weather_num && each_pair.hit_planed.stick_id == user_stick.stick.id && each_pair.hit_planed.game.field_id == c_field.id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
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
              @all_pairs = PairHit.where(:user_id => c_user.id)
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.trajectory == trajectory_num && each_pair.hit_planed.stick_id == user_stick.stick.id && each_pair.hit_planed.game.field_id == c_field.id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
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
              @all_pairs = PairHit.where(:user_id => c_user.id)
          
              @result_arr = []
        
              @all_pairs.each do |each_pair|
                if each_pair.hit_planed.wind == wind_num && each_pair.hit_planed.stick_id == user_stick.stick.id && each_pair.hit_planed.game.field_id == c_field.id
                  @add_to_arr = calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real)
                  @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
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
          end # end user
        end # ends game
      end # end field
    end # end stick
   
    return @return
  end
  



  #================================================
  # Game statistics
  def self.game_filter_statistic
    @return = false
    GameFilterStatistic.delete_all

    @games = Game.order("date DESC")
    @games.each do |c_game|

      @GameFilterStatistic = GameFilterStatistic.new
      @GameFilterStatistic.game_id = c_game.id
      @GameFilterStatistic.user_id = c_game.user_id
      @GameFilterStatistic.field_id = c_game.field_id

      @avg_r_distance = []
      @avg_p_distance = []
      @hit_sum = 0

      PairHit.where(:game_id => c_game.id).each do |c_pair|

        puts "======================="
        puts "c_pair.hit_real.hit_distance #{c_pair.hit_real.hit_distance}"
        puts "c_pair.hit_planed.hit_distance #{c_pair.hit_planed.hit_distance}"
        
        @avg_r_distance = @avg_r_distance.push(c_pair.hit_real.hit_distance) unless c_pair.hit_real.hit_distance == nil
        @avg_p_distance = @avg_p_distance.push(c_pair.hit_planed.hit_distance)unless c_pair.hit_planed.hit_distance == nil
        @hit_sum = @hit_sum + 1

       
        
        case c_pair.hit_planed.place_from
        when 1
          @GameFilterStatistic.place_green = true
        when 2
          @GameFilterStatistic.place_teebox = true
        when 3
          @GameFilterStatistic.place_feairway = true
        when 4
          @GameFilterStatistic.place_next_fairway = true
        when 5
          @GameFilterStatistic.place_semi_raf = true
        when 6
          @GameFilterStatistic.place_raf = true
        when 7
          @GameFilterStatistic.place_for_green = true
        when 8
          @GameFilterStatistic.place_fairway_sand = true
        when 9
          @GameFilterStatistic.place_green_sand = true
        when 10
          @GameFilterStatistic.place_wood = true
        when 11
          @GameFilterStatistic.place_from_water = true
        end

        case c_pair.hit_planed.stance
        when 1
          @GameFilterStatistic.stance_normal = true
        when 2
          @GameFilterStatistic.stance_right_leg_lower = true
        when 3
          @GameFilterStatistic.stance_left_leg_lower = true
        when 4
          @GameFilterStatistic.stance_ball_lower = true
        when 5
          @GameFilterStatistic.stance_ball_higher = true
        end

        case c_pair.hit_planed.direction
        when 1
          @GameFilterStatistic.direction_straigth = true
        when 2
          @GameFilterStatistic.direction_fade = true
        when 3
          @GameFilterStatistic.direction_drow = true
        when 4
          @GameFilterStatistic.direction_slice = true
        when 5
          @GameFilterStatistic.direction_hook = true
        end

        case Game.find(c_pair.hit_planed.game_id).temperature
        when 1
          @GameFilterStatistic.temperature_hot = true
        when 2
          @GameFilterStatistic.temperature_normal = true
        when 3
          @GameFilterStatistic.temperature_cold = true
        end

        case Game.find(c_pair.hit_planed.game_id).weather
        when 1
          @GameFilterStatistic.weather_normal = true
        when 2
          @GameFilterStatistic.weather_wind = true
        when 3
          @GameFilterStatistic.weather_rain = true
        when 4
          @GameFilterStatistic.weather_wind_and_rain = true
        end

        case c_pair.hit_planed.trajectory
        when 1
          @GameFilterStatistic.trajectory_normal = true
        when 2
          @GameFilterStatistic.trajectory_high = true
        when 3
          @GameFilterStatistic.trajectory_low = true
        end

        case c_pair.hit_planed.wind
        when 1
          @GameFilterStatistic.wind_from_behind = true
        when 2
          @GameFilterStatistic.wind_from_front = true
        when 3
          @GameFilterStatistic.wind_from_left = true
        when 4
          @GameFilterStatistic.wind_from_right = true
        end
      end # end pair hit

      puts "----------------------"
      puts "now the array:"
      puts "@avg_r_distances: #{@avg_r_distance.join(".")}"
      puts "@avg_p_distances: #{@avg_p_distance.join(".")}"
      

      puts ""
      puts ""

      #@avg_r = (@avg_r_distance.inject(0.0) { |sum, el| sum + el } / @avg_r_distance.size).round unless @avg_r_distance.size == 0
      #@avg_p = (@avg_p_distance.inject(0.0) { |sum, el| sum + el } / @avg_p_distance.size).round unless @avg_p_distance.size == 0
      @avg_r = (@avg_r_distance.sum /  @avg_r_distance.size).to_i unless @avg_r_distance.size == 0
      @avg_p = (@avg_p_distance.sum /  @avg_p_distance.size).to_i unless @avg_p_distance.size == 0

      puts "@avg_r: #{@avg_r}"
      puts "@avg_p: #{@avg_p}"

      puts ""
      puts "@avg_r.class: #{@avg_r.class}"
      puts "@avg_p.class: #{@avg_p.class}"

      
      if @avg_r.to_i > @avg_p.to_i

        puts "@avg_r > @avg_p"
        @GameFilterStatistic.avg_r_distance = 100
        @GameFilterStatistic.avg_p_distance = (@avg_p / @avg_r) * 100

      elsif @avg_p.to_i < @avg_p.to_i

        puts "@avg_r < @avg_p"
        @GameFilterStatistic.avg_r_distance = 100
        @GameFilterStatistic.avg_p_distance = (@avg_r / @avg_p) * 100

      elsif @avg_p.to_i == @avg_r.to_i

        puts "@avg_r = @avg_p"
        @GameFilterStatistic.avg_r_distance = 100
        @GameFilterStatistic.avg_p_distance = 100

      end #unless @avg_r == nil or @avg_p == nil

      @GameFilterStatistic.hit_sum = @hit_sum
      @GameFilterStatistic.save
    end # end game
  end


      
=begin
  def self.game_filter_statistic

    @return = false
    GameFilterStatistic.delete_all

    @games = Game.order("date DESC")
    @games.each do |c_game|

      @avg_r_distance = []
      @avg_p_distance = []
      @hit_sum = 0
      
      PairHit.where(:game_id => c_game.id).each do |c_pairhit|
        @avg_r_distance = @avg_r_distance.push(c_pairhit.hit_real.hit_distance)
        @avg_p_distance = @avg_p_distance.push(c_pairhit.hit_planed.hit_distance)
        @hit_sum = @hit_sum + 1
      end # end PairHit

      @GameFilterStatistic = GameFilterStatistic.new
      @GameFilterStatistic.game_id = c_game.id
      @GameFilterStatistic.user_id = c_game.user_id
      @GameFilterStatistic.field_id = c_game.field_id
      @GameFilterStatistic.hit_sum = @hit_sum


      @avg_r = (@avg_r_distance.inject(0.0) { |sum, el| sum + el } / @avg_r_distance.size).round unless @avg_r_distance.size == 0
      @avg_p = (@avg_p_distance.inject(0.0) { |sum, el| sum + el } / @avg_p_distance.size).round unless @avg_p_distance.size == 0

      if @avg_r > @avg_p
        @GameFilterStatistic.avg_r_distance = 100
        @GameFilterStatistic.avg_p_distance = (@avg_p / @avg_r) * 100
      elsif @avg_p < @avg_p
        @GameFilterStatistic.avg_r_distance = 100
        @GameFilterStatistic.avg_p_distance = (@avg_r / @avg_p) * 100
      end unless @avg_r == nil or @avg_p == nil

      
      @GameFilterStatistic.place_from =  c_pairhit.hit_real.place_from
      @GameFilterStatistic.stance = c_pairhit.hit_real.stance
      @GameFilterStatistic.direction =  c_pairhit.hit_real.direction      
      @GameFilterStatistic.temperature = Game.find(c_pairhit.hit_real.game_id).temperature
      @GameFilterStatistic.trajectory = c_pairhit.hit_real.trajectory
      @GameFilterStatistic.wind = c_pairhit.hit_real.wind
      

      @return = true if @GameFilterStatistic.save
    end # end game
    return @return
  end
=end
  
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

        game_s_holes.hole_id = c_hole.id
        game_s_holes.hole_number = c_hole.hole_number
        
        game_s_holes.put_sum = @hit_r.where(:place_from => 1).count
        game_s_holes.gir_sum = @hit_r.where(:place_from => 1, :hit_number => 2).count
        game_s_holes.hit_sum = @hit_r.count

        @hit_p = Hit.where(:real_hit => "pp").order("hit_number")
        @hit_r = Hit.where(:real_hit => "rp").order("hit_number")

        game_s_holes.hit_p = @hit_p.count
        game_s_holes.hit_r = @hit_r.count

        game_s_holes.puts_p = @hit_p.where(:place_from => 1).count
        game_s_holes.puts_r = @hit_r.where(:place_from => 1).count
        
        @stick_order_p_arr = []
        @stick_order_r_arr = []
        
        @hit_p.each do |c_p_hit|
          begin
            @c_stick_id = Stick.find(c_p_hit.stick_id)
            @stick_order_p_arr.push(@c_stick_id.short_name) unless @c_stick_id
          rescue
          end
        end
        
        @hit_r.each do |c_r_hit|
          begin
            @c_stick_id = Stick.find(c_r_hit.stick_id) || nil
            @stick_order_r_arr.push(@c_stick_id.short_name) unless @c_stick_id == nil
          rescue
          end
        
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
      @user_sticks = UsersStick.where(:user_id => c_game.user_id)
      @user_sticks.each do |c_user_stick|
      
        game_s_sticks = GameStatisticsBySticks.new
        game_s_sticks.game_id = c_game.id
        game_s_sticks.fields_id = c_game.field_id
        game_s_sticks.users_stick_id = c_user_stick.id
        game_s_sticks.user_id = @user.id

        @hit_p = Hit.where("real_hit = 'p' OR real_hit = 'pp'").where(:stick_id => c_user_stick.stick_id, :game_id => c_game.id).order("hit_number ASC")
        @hit_r = Hit.where("real_hit = 'r' OR real_hit = 'rp'").where(:stick_id => c_user_stick.stick_id, :game_id => c_game.id).order("hit_number ASC")
        
        game_s_sticks.hits_p = @hit_p.count
        game_s_sticks.hits_r = @hit_r.count
        
        @all_hits = Hit.all
        @all_current_stick_hits = Hit.where(:stick_id => c_user_stick.stick_id, :game_id => c_game.id)
        @avg = ((@all_current_stick_hits.count.to_f / @all_hits.count.to_f).to_f * 100).round
        game_s_sticks.stick_usage = @avg
        game_s_sticks.avg_distance = @all_current_stick_hits.average("hit_distance") #@all_current_stick_hits.count
        
        @return = true if game_s_sticks.save
        
      end # ends user stick
    end # ends game
    
    return @return
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

          @user_progres_arr.push(c_stat.direction_straigth) unless c_stat.direction_straigth == nil
          @user_progres_arr.push(c_stat.direction_fade) unless c_stat.direction_fade == nil
          @user_progres_arr.push(c_stat.direction_drow) unless c_stat.direction_drow == nil
          @user_progres_arr.push(c_stat.direction_slice) unless c_stat.direction_slice == nil
          @user_progres_arr.push(c_stat.direction_hook) unless c_stat.direction_hook == nil

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

          @user_progres_arr.push(c_stat.wind_from_behind) unless c_stat.wind_from_behind == nil
          @user_progres_arr.push(c_stat.wind_from_front) unless c_stat.wind_from_front == nil
          @user_progres_arr.push(c_stat.wind_from_left) unless c_stat.wind_from_left == nil
          @user_progres_arr.push(c_stat.wind_from_right) unless c_stat.wind_from_right == nil
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
  
  
  def self.all_sticks_statistics
    AllStickStatistic.delete_all
    
    @return = false
    
    @users = User.all
    @users.each do |c_user|
     
      @users_stick = UsersStick.where(:user_id => c_user.id)
      @users_stick.each do |c_users_stick|
    
        @AllStickStatistics = AllStickStatistic.new
        
        @all_hits = Hit.where(:user_id => c_user.id)
        @all_c_hits = Hit.where(:user_id => c_user.id, :stick_id => c_users_stick.stick.id)
        
        @AllStickStatistics.user_id = c_user.id
        @AllStickStatistics.stick_id = c_users_stick.stick.id
        @AllStickStatistics.avg_distance = @all_c_hits.average("hit_distance")

        unless @all_hits.count == 0 || @all_c_hits == 0
          @AllStickStatistics.usage = (((@all_c_hits.count).to_f / (@all_hits.count).to_f).to_f * 100).round
        end

        @all_pair_hits = PairHit.where(:user_id == c_user.id)



        @result_arr = []

        @all_pair_hits.each do |c_pair_hit|
          if c_pair_hit.hit_real.stick_id == c_users_stick.stick.id
            @add_to_arr = calculate_current_statistics(c_pair_hit.hit_planed, c_pair_hit.hit_real)
            @result_arr.push(@add_to_arr) unless (@add_to_arr == false || @add_to_arr == nil)
          end
        end

        if @result_arr.size == 0
          @AllStickStatistics.stick_progres = 0
        else
          @AllStickStatistics.stick_progres = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).round
        end

        @return = true if @AllStickStatistics.save

      end
    end # ends user stick
   
    return @return
  end

  
  
  def self.check_golf_club_pay_banner_time_limit
    @return = true
      
    @golf_clubs = GolfClub.all
      
    @golf_clubs.each do |c_club|
      c_club.update_attributes(:is_p_banner_disabled => true) if (c_club.pay_banner_end_date > DateTime.now) && c_club.is_p_banner_disabled == false
    end
    
    return @return
  end

  def self.user_progres

    StatisticUserProgres.delete_all

    @return = false
    @users = User.all

    @users.each do |c_user|

      Field.all.each do |c_field|
        @Statistic = Statistic.where(:field_id => c_field.id, :user_id => c_user.id)
        
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

          @user_progres_arr.push(c_stat.direction_straigth) unless c_stat.direction_straigth == nil
          @user_progres_arr.push(c_stat.direction_fade) unless c_stat.direction_fade == nil
          @user_progres_arr.push(c_stat.direction_drow) unless c_stat.direction_drow == nil
          @user_progres_arr.push(c_stat.direction_slice) unless c_stat.direction_slice == nil
          @user_progres_arr.push(c_stat.direction_hook) unless c_stat.direction_hook == nil
        
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

          @user_progres_arr.push(c_stat.wind_from_behind) unless c_stat.wind_from_behind == nil
          @user_progres_arr.push(c_stat.wind_from_front) unless c_stat.wind_from_front == nil
          @user_progres_arr.push(c_stat.wind_from_left) unless c_stat.wind_from_left == nil
          @user_progres_arr.push(c_stat.wind_from_right) unless c_stat.wind_from_right == nil

        end # end statistic
        
        unless @user_progres_arr.size == 0
          @user_stats_progres_val = (@user_progres_arr.inject(0.0) { |sum, el| sum + el } / @user_progres_arr.size).round

          @u_statsProg = StatisticUserProgres.new
          @u_statsProg.user_progress = @user_stats_progres_val
          @u_statsProg.user_id = c_user.id
          @u_statsProg.field_id = c_field.id
          @u_statsProg.hcp = c_user.hcp

          @return = true if @u_statsProg.save
        end


      end # ends field
    end # end user

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