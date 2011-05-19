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
  
  def self.calculate_current_statistics(planed, real) # p = planed, r = Real
    p = planed.hit_distance
    r = real.hit_distance
    
    @result = ((1 - ((r.to_f - p.to_f).abs / p.to_f)).round(2) * 100).to_i
       
    #@result = @result - calculate_diference(planed.trajectory, real.trajectory)
    #@result = @result - calculate_diference(planed.hit_was, real.hit_was)
    #@result = @result - calculate_diference(planed.motion_was, real.motion_was)
    #@result = @result - calculate_diference(planed.misdirection, real.misdirection)
        
    if @result > 100
      return 100
    elsif @result < 1
      return 1
    else
      return @result
    end
  end
  
  
  def self.calculate_statistics

    @good = false
    
    3.times { puts "============================================xx" }
  
    Statistic.delete_all
  
    @users = User.all 
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
              @result_arr.push(calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real))
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
              @result_arr.push(calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real))
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
              @result_arr.push(calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real))
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
              @result_arr.push(calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real))
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
              @result_arr.push(calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real))
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
              @result_arr.push(calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real))
            end
          end

          case trajectory_num 
          when 1
            if @result_arr.size != 0
              puts "    trajectory: Normal: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.trajectory_normal = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 2
            if @result_arr.size != 0
              puts "    trajectory: High: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
              statistic.trajectory_high = (@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i
            end
          when 3
            if @result_arr.size != 0
              puts "    trajectory: Low: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
              puts "   ---"
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
              @result_arr.push(calculate_current_statistics(each_pair.hit_planed, each_pair.hit_real))
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
  

  
  
end