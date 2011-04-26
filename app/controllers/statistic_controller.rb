class StatisticController < ApplicationController

  
  
  def statistics
    @users = User.all    

    puts "======================"
    
    # user
    @users.each do |user|
      puts "* user: #{ user.email } "
        
        # user stick
        user.users_sticks.each do |user_stick|
          puts "  - stick: #{ user_stick.stick.stick_type } "
            
          
           x = PairHit.find(sticks_id = user_stick.id? && user_id = user.id?)
           
           puts "      PairHit.id = #{x.id}"
           puts "      PairHit.sticks_id = #{x.sticks_id}"
           puts "      PairHit.hit_planed_id = #{x.hit_planed.id}"
           puts "      PairHit.hit_real_id = #{x.hit_real.id}"
          
          
          
            /
            PairHit.find(sticks_id = user_stick.id).each do |x|
              puts "        hit id: {x.id}"
            end
          
          
          end
          / 
           
          / 
          if @pair_hits != nil
            @pair_hits.each do |pair_hit|
              puts "     pair hit id: { pair_hit.id }"
            end
          end
          /
        end # user stick
        
    puts ""
    
    end # user
    
    puts ""
    puts ""
    puts "======================"
  end
    

end
