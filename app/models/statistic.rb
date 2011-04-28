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
            
            if place_from == 1
              puts "          - Teebox"
            elsif place_from == 2
              puts "          - feairway"
            elsif place_from == 3
              puts "          - Next fairway"
            elsif place_from == 4
              puts "          - Semi raf"
            elsif place_from == 5
              puts "          - Raf"
            elsif place_from == 6
              puts "          - For green"
            elsif place_from == 7
              puts "          - Green"
            elsif place_from == 8
              puts "          - Fairway sand"
            elsif place_from == 9
              puts "          - Green sand"
            elsif place_from == 10
              puts "          - Wood"
            elsif place_from == 11
              puts "          - From water"
            else
              puts "          - N"
            end
            #place ===================================================
             
            #stance ===================================================
            stance = pair_hit.hit_planed.stance
            
            if stance == 1
              puts "          - Normal"
            elsif stance == 2
              puts "          - Right leg lower"
            elsif stance == 3
              puts "          - Left leg lower"
            elsif stance == 4
              puts "          - Ball lower"
            elsif stance == 5
              puts "          - Ball higher"
            else
              puts "          - N"
            end
            #place ===================================================
             
            #direction ==================================================
            direction = pair_hit.hit_planed.direction
            
            if direction == 1
              puts "          - Straigth"
            elsif direction == 2
              puts "          - Fade"
            elsif direction == 3
              puts "          - Drow"
            elsif direction == 4
              puts "          - Slice"
            elsif direction == 5
              puts "          - Hook"
            else
              puts "          - N"
            end
            #direction ===================================================
             
            #temperature ==================================================
            temperature = Game.find(pair_hit.hit_planed.game_id).temperature
            
            if temperature == 3
              puts "          - Cold"
            elsif temperature == 2
              puts "          - Normal"
            elsif temperature == 1
              puts "          - Hot"
            else
              puts "          - N"
            end
            #temperature ===================================================
            
             #weather ==================================================
            weather = Game.find(pair_hit.hit_planed.game_id).weather
            
            if weather == 1
              puts "          - Normal"
            elsif weather == 2
              puts "          - Wind"
            elsif weather == 3
              puts "          - Rain"
            elsif weather == 4
              puts "          - Wind and Rain"
            else
              puts "          - N"
            end
            #weather ===================================================
             
             #trajectory ==================================================
            trajectory = pair_hit.hit_planed.trajectory
            
            if trajectory == 1
              puts "          - Normal"
            elsif trajectory == 2
              puts "          - High"
            elsif trajectory == 3
              puts "          - Low"
            else
              puts "          - N"
            end
            #trajectory ===================================================
             
             
             
                      
          end

        end # user stick
        
      puts ""
      puts ""
      puts ""
      puts "======================"
    
    end # user
    
    
  end
end
