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
            
            
            #place ===================================================
            place_from = pair_hit.hit_planed.place_from
            
            if place_from == "Teebox"
              puts "          - Teebox"
            elsif place_from == "feairway"
              puts "          - feairway"
            elsif place_from == "Next fairway"
              puts "          - Next fairway"
            elsif place_from == "Semi raf"
              puts "          - Semi raf"
            elsif place_from == "Raf"
              puts "          - Raf"
            elsif place_from == "For green"
              puts "          - For green"
            elsif place_from == "Green"
              puts "          - Green"
            elsif place_from == "Fairway sand"
              puts "          - Fairway sand"
            elsif place_from == "Green sand"
              puts "          - Green sand"
            elsif place_from == "Wood"
              puts "          - Wood"
            elsif place_from == "From water"
              puts "          - From water"
            else
              puts "          - N"
            end
            #place ===================================================
             
            #stance ===================================================
            stance = pair_hit.hit_planed.stance
            
            if stance == "Normal"
              puts "          - Normal"
            elsif stance == "Right leg lower"
              puts "          - Right leg lower"
            elsif stance == "Left leg lower"
              puts "          - Left leg lower"
            elsif stance == "Ball lower"
              puts "          - Ball lower"
            elsif stance == "Ball higher"
              puts "          - Ball higher"
            else
              puts "          - N"
            end
            #place ===================================================
             
            #direction ==================================================
            direction = pair_hit.hit_planed.direction
            
            if direction == "Straigth"
              puts "          - Straigth"
            elsif direction == "Fade"
              puts "          - Fade"
            elsif direction == "Drow"
              puts "          - Drow"
            elsif direction == "Slice"
              puts "          - Slice"
            elsif direction == "Hook"
              puts "          - Hook"
            else
              puts "          - N"
            end
            #direction ===================================================
             
            #temperature ==================================================
            temperature = Game.find(pair_hit.hit_planed.game_id).temperature
            
            if temperature == "Cold"
              puts "          - Cold"
            elsif temperature == "Normal"
              puts "          - Normal"
            elsif temperature == "Hot"
              puts "          - Hot"
            else
              puts "          - N"
            end
            #temperature ===================================================
            
             #weather ==================================================
            weather = Game.find(pair_hit.hit_planed.game_id).weather
            
            if weather == "Normal"
              puts "          - Normal"
            elsif weather == "Wind"
              puts "          - Wind"
            elsif weather == "Rain"
              puts "          - Rain"
            elsif weather == "Wind and Rain"
              puts "          - Wind and Rain"
            else
              puts "          - N"
            end
            #weather ===================================================
             
             
             
             
                      
          end

        end # user stick
        
      puts ""
      puts ""
      puts ""
      puts "======================"
    
    end # user
    
    
  end
end
