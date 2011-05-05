class Statistic < ActiveRecord::Base
  has_many  :users
  has_many  :hits
  scope :game, :joins => {:game => :hit}
  scope :stick, :joins => {:stick => :user_stick}
  
  #scope :get_place_from, lambda { |place| where('place_from = ?', place) }
  
  def self.get_average_from_array(arr)
    @result
    
    arr.each do |arre|
      @result = @result + arre
    end
    
    @restult = @result.to_f / arr.size
    return @result
  end
  
  def self.calculate_current_statistics(p, r) # p = planed, r = Real
      #@result = ((1 - ((r.to_f - p.to_f).abs / p.to_f)).round(2) * 100).to_i
      @result = ((1 - ((r.to_f - p.to_f).abs / p.to_f)).round(2) * 100).to_i
      if @result > 100
        return 100
      elsif @result == 0
        return 1
      else
        return @result
      end
  end
  
  
def self.calculate_statistics

  3.times { puts "============================================xx" }
  
  
  @users = User.all 
  @users.each do |user|
    puts ""
    puts "user_id #{user.id}"
    puts ""
    user.users_sticks.each do |user_stick|
        puts " stick_id #{user_stick.stick.id}"
        
        #CALCULATE PLACE_FROM
        # ==========================================
        for place_from_num in 1..11 do
          @all_pairs = PairHit.where(:users_id => user.id)
          
          @result_arr = []
        
          @all_pairs.each do |each_pair|
            if each_pair.hit_planed.place_from == place_from_num && each_pair.hit_planed.stick_id == user_stick.stick.id
               @result_arr.push(calculate_current_statistics(each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance))
            end
          end

          case place_from_num 
            when 1
              if @result_arr.size != 0
                puts "    place from: Teebox: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 2
              if @result_arr.size != 0
                puts "    place from: Feairway: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 3
              if @result_arr.size != 0
                puts "    place from: Next fairway: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 4
              if @result_arr.size != 0
                puts "    place from: Semi raf: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 5
              if @result_arr.size != 0
                puts "    place from: Raf: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 6
              if @result_arr.size != 0
                puts "    place from: For green: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 7
              if @result_arr.size != 0
                puts "    place from: Green: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 8
              if @result_arr.size != 0
                puts "    place from: Fairway sand: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 9
              if @result_arr.size != 0
                puts "    place from: Green sand: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 11
              if @result_arr.size != 0
                puts "    place from: Wood: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 11
              if @result_arr.size != 0
                puts "    place from: From water: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
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
               @result_arr.push(calculate_current_statistics(each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance))
            end
          end

          case stance_num 
            when 1
              if @result_arr.size != 0
                puts "    stance: Normal: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 2
              if @result_arr.size != 0
                puts "    stance: Right leg lower: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 3
              if @result_arr.size != 0
                puts "    stance: Left leg lower: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 4
              if @result_arr.size != 0
                puts "    stance: Ball lower: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 5
              if @result_arr.size != 0
                puts "    stance: Ball higher: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
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
               @result_arr.push(calculate_current_statistics(each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance))
            end
          end

          case direction_num 
            when 1
              if @result_arr.size != 0
                puts "    direction: Straigth: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 2
              if @result_arr.size != 0
                puts "    direction: Fade: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 3
              if @result_arr.size != 0
                puts "    direction: Drow: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 4
              if @result_arr.size != 0
                puts "    direction: Slice: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 5
              if @result_arr.size != 0
                puts "    direction: Hook: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
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
               @result_arr.push(calculate_current_statistics(each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance))
            end
          end

          case temperature_num 
            when 1
              if @result_arr.size != 0
                puts "    temperature: Hot: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 2
              if @result_arr.size != 0
                puts "    temperature: Normal: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 3
              if @result_arr.size != 0
                puts "    temperature: Cold: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
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
               @result_arr.push(calculate_current_statistics(each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance))
            end
          end

          case weather_num 
            when 1
              if @result_arr.size != 0
                puts "    weather: Normal: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 2
              if @result_arr.size != 0
                puts "    weather: Wind: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 3
              if @result_arr.size != 0
                puts "    weather: Rain: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 4
              if @result_arr.size != 0
                puts "    weather: Wind and Rain: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
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
               @result_arr.push(calculate_current_statistics(each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance))
            end
          end

          case trajectory_num 
            when 1
              if @result_arr.size != 0
                puts "    trajectory: Normal: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 2
              if @result_arr.size != 0
                puts "    trajectory: High: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 3
              if @result_arr.size != 0
                puts "    trajectory: Low: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
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
               @result_arr.push(calculate_current_statistics(each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance))
            end
          end

          case wind_num 
            when 1
              if @result_arr.size != 0
                puts "    wind: From behind: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 2
              if @result_arr.size != 0
                puts "    wind: From front: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 3
              if @result_arr.size != 0
                puts "    wind: From right: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 4
              if @result_arr.size != 0
                puts "    wind: From behind: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
          end
        end
        # ==========================================
        
      end
    end
  puts ""
  3.times { puts "============================================xx" }
  end
  

end