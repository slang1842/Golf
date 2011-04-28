class Statistic < ActiveRecord::Base
  has_many  :users
  has_many  :hits
  
  #scope :get_place_from, lambda { |place| where('place_from = ?', place) }
  
  #def calculate_current_statistics(P, R) # P = planed, R = Real
  #  if P = 0
  #    return "N"
  #  else
  #    @result = 0
  #    @result = 1 - ((R - P).abs / P)
  #    return @result 
  #  end
  #end
  
  
  def self.calculate_statistics
  
  @users = User.all    

    puts "======================"
    
    # user
    @users.each do |user|
      puts "* user: #{ user.email } (id: #{user.id} )  "
        
        # user stick
        user.users_sticks.each do |user_stick|
          puts "  - stick: #{ user_stick.stick.stick_type } (id: #{user_stick.stick.id}) "
          
          @PairHits = user_stick.pair_hits.all
          
          @PairHits.each do |pair_hit|
            puts "      pair hit id: #{ pair_hit.id }"
            puts "        pair hit planed hit id: #{ pair_hit.hit_planed.id }"
            puts "        pair hit real hit id: #{ pair_hit.hit_real.id }"
            
            
            #place
            place_from = pair_hit.hit_planed.place_from
            
            if place_from == nil
               puts "          - N"
              else
                STATISTICS_PLACE_FROM.each do |p_f|
                  
                  #puts p_f
                  if place_from == p_f
                    puts "          - #{place_from} "
                  end
                end
              end
           puts ""
           
            /
            if @place_from == "teebox"
              puts "        --- teebox"
              
            elsif @place_from == "eairway"
              puts "        --- eairway"
            elsif @place_from == "next fairway"
              puts "        --- next fairway"
            elsif @place_from == "semi raf"
              puts "        --- semi raf"
            elsif @place_from == "raf"
              puts "        --- raf"
            elsif @place_from == "for green"
              puts "        --- for green"
              
            elsif @place_from == "green"
              puts "        --- green"
            elsif @place_from == "fairway sand"
              puts "        --- fairway sand"
            elsif @place_from == "green sand"
              puts "        --- green sand"
            elsif @place_from == "wood"
              puts "        --- wood"
            elsif @place_from == "from water"
              puts "        --- from water"
            else
              puts "        --- N"
            end
            
            
            @place_from = case pair_hit.hit_planed.place_from
              when "teebox" then 
              when "eairway" then
              when "next fairway" then 
              when "semi raf" then 
              when "raf" then 
              when "for green" then 
              when "green" then 
              when "fairway sand" then 
              when "green sand" then 
              when "wood" then 
              when "from water" then 
            end
            /
            
            
            #statistic ===================================================
           
            /
            @place_eairway = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "eairway"), pair_hit.hit_real.hit_distance.where(place_from = "eairway"))
            @place_next_fairway = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "next fairway"), pair_hit.hit_real.hit_distance.where(place_from = "next fairway"))
            @place_semi_raf = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "semi raf"), pair_hit.hit_real.hit_distance.where(place_from = "semi raf"))
            @place_raf = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "raf"), pair_hit.hit_real.hit_distance.where(place_from = "raf"))
            @place_for_green = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "for green"), pair_hit.hit_real.hit_distance.where(place_from = "for green"))
            @place_green = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "green"), pair_hit.hit_real.hit_distance.where(place_from = "green"))
            @place_fairway_sand = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "fairway sand"), pair_hit.hit_real.hit_distance.where(place_from = "fairway sand"))
            @place_green_sand = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "green sand"), pair_hit.hit_real.hit_distance.where(place_from = "green sand"))
            @place_wood = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "wood"), pair_hit.hit_real.hit_distance.where(place_from = "wood"))
            @place_from_water = calculate_current_statistics(pair_hit.hit_planed.hit_distance.where(place_from = "from water"), pair_hit.hit_real.hit_distance.where(place_from = "from water"))
            /
            #statistic ===================================================
            
            
          end

        end # user stick
        
      puts ""
      puts ""
      puts ""
      puts "======================"
    
    end # user
    
    
  end
end
