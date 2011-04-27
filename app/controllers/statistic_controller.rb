class StatisticController < ApplicationController

  
  
  def statistics
    @users = User.all    

    puts "======================"
    
    # user
    @users.each do |user|
      puts "* user: #{ user.email } (id: )  "
        
        # user stick
        user.users_sticks.each do |user_stick|
          puts "  - stick: #{ user_stick.stick.stick_type } (id: #{user_stick.stick.id}) "
          
          @PairHits = user_stick.pair_hits.all
          
          @PairHits.each do |pair_hit|
            puts "      pair hit id: #{ pair_hit.id }"
            puts "        pair hit planed hit id: #{ pair_hit.hit_planed.id }"
            puts "        pair hit real hit id: #{ pair_hit.hit_real.id }"
          end

        end # user stick
        
    puts ""
    
    end # user
    
    puts ""
    puts ""
    puts "======================"
  end
    

end
