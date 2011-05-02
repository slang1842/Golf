class Statistic < ActiveRecord::Base
  has_many  :users
  has_many  :hits
  scope :game, :joins => {:game => :hit}
  
  #scope :get_place_from, lambda { |place| where('place_from = ?', place) }
  
  def self.calculate_current_statistics(p, r) # P = planed, R = Real
    if p == 0
      return "N"
    else
      @result = 0
      @result = 1 - ((r.to_i - p.to_i).abs / p.to_i)
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
        puts " stick_id #{user_stick.id}"
        
        #CALCULATE PLACE_FROM
        # ==========================================
        for place_from_num in 1..11 do
          @all_hits = Hit.where(:user_id => user.id, :stick_id => user_stick.id, :place_from => place_from_num)
          @PID = user_stick.pair_hits.all
          @PID.each do |each_pair|
            if each_pair.hit_planed.place_from == place_from_num
              #calculate_place_from(place_from_num, each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance)
                puts "      -----"
                puts "      place from: #{place_from_num}"
                puts "      Planotais sitiens: #{each_pair.hit_planed.hit_distance }"
                puts "      Realais sitiens: #{each_pair.hit_real.hit_distance }"
                puts "      ====="
            else
            end
          end
        end
        # ==========================================
        

        #CALCULATE STANCE
        # ==========================================
        for stance_num in 1..5 do
          @all_hits = Hit.where(:user_id => user.id, :stick_id => user_stick.id, :stance => stance_num)
          @PID = user_stick.pair_hits.all
          @PID.each do |each_pair|
            if each_pair.hit_planed.stance == stance_num
              #calculate_stance(stance_num, each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance)
                puts "      -----"
                puts "      stance: #{stance_num}"
                puts "      Planotais sitiens: #{each_pair.hit_planed.hit_distance }"
                puts "      Realais sitiens: #{each_pair.hit_real.hit_distance }"
                puts "      ====="
            else
            end
          end
        end
        # ==========================================
        
        #CALCULATE DIRECTION
        # ==========================================
        for direction_num in 1..5 do
          @all_hits = Hit.where(:user_id => user.id, :stick_id => user_stick.id, :direction => direction_num)
          @PID = user_stick.pair_hits.all
          @PID.each do |each_pair|
            if each_pair.hit_planed.direction == direction_num
              #calculate_stance(direction_num, each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance)
                puts "      -----"
                puts "      direction: #{direction_num}"
                puts "      Planotais sitiens: #{each_pair.hit_planed.hit_distance }"
                puts "      Realais sitiens: #{each_pair.hit_real.hit_distance }"
                puts "      ====="
            else
            end
          end
        end
        # ==========================================
        
        #CALCULATE TEMPERATURE
        # ==========================================
        for direction_num in 1..5 do
          @all_hits = Hit.where(:user_id => user.id, :stick_id => user_stick.id, "game.temperature" => direction_num)
          @PID = user_stick.pair_hits.all
          @PID.each do |each_pair|
            if each_pair.hit_planed.direction == direction_num
              #calculate_stance(direction_num, each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance)
                puts "      -----"
                puts "      temperature: #{direction_num}"
                puts "      Planotais sitiens: #{each_pair.hit_planed.hit_distance }"
                puts "      Realais sitiens: #{each_pair.hit_real.hit_distance }"
                puts "      ====="
            else
            end
          end
        end
        # ==========================================
        
         #CALCULATE WEATHER
        # ==========================================
        for weather_num in 1..4 do
          @all_hits = Hit.where(:user_id => user.id, :stick_id => user_stick.id, "game.weather" => weather_num)
          @PID = user_stick.pair_hits.all
          @PID.each do |each_pair|
            if each_pair.hit_planed.direction == weather_num
              #calculate_stance(weather_num, each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance)
                puts "      -----"
                puts "      weather: #{weather_num}"
                puts "      Planotais sitiens: #{each_pair.hit_planed.hit_distance }"
                puts "      Realais sitiens: #{each_pair.hit_real.hit_distance }"
                puts "      ====="
            else
            end
          end
        end
        # ==========================================
        
        #CALCULATE TRAJECTORY
        # ==========================================
        for trajectory_num in 1..3 do
          @all_hits = Hit.where(:user_id => user.id, :stick_id => user_stick.id, :trajectory => trajectory_num)
          @PID = user_stick.pair_hits.all
          @PID.each do |each_pair|
            if each_pair.hit_planed.trajectory == trajectory_num
              #calculate_stance(trajectory_num, each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance)
                puts "      -----"
                puts "      trajectory: #{trajectory_num}"
                puts "      Planotais sitiens: #{each_pair.hit_planed.hit_distance }"
                puts "      Realais sitiens: #{each_pair.hit_real.hit_distance }"
                puts "      ====="
            else
            end
          end
        end
        # ==========================================
        
        
        #CALCULATE WIND
        # ==========================================
        for wind_num in 1..4 do
          @all_hits = Hit.where(:user_id => user.id, :stick_id => user_stick.id, :wind => wind_num)
          @PID = user_stick.pair_hits.all
          @PID.each do |each_pair|
            if each_pair.hit_planed.wind == wind_num
              #calculate_stance(wind_num, each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance)
                puts "      -----"
                puts "      wind: #{wind_num}"
                puts "      Planotais sitiens: #{each_pair.hit_planed.hit_distance }"
                puts "      Realais sitiens: #{each_pair.hit_real.hit_distance }"
                puts "      ====="
            else
            end
          end
        end
        # ==========================================
        
        
        
      end
    end
  puts ""
  3.times { puts "============================================xx" }
  end
  

  
  def calculate_place_from
    case place_from_num 
      when 1
      puts "    Teebox"
      when 2
      puts "    Feairway"
      when 3
        puts "    Next fairway"
      when 4
        puts "    Semi raf"
      when 5
        puts "    Raf"
      when 6
        puts "    For green"
      when 7
        puts "    Green"
      when 8
        puts "    Fairway sand"
      when 9
        puts "    Green sand"
      when 11
        puts "    Wood"
      when 11
        puts "    From water"
    end
  end
end