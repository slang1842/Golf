class StatisticController < ApplicationController

  
  
  def statistics
    @users = User.all
        
    puts "======================"
    
    #users
    @users.each do |user|
      puts ""
      puts "user id: #{user.id}"
      puts "user name: #{user.first_name}"
      puts ""
      #users sticks
      user.users_sticks.each do |user_stick|
        puts " - user stick id: #{user_stick.id}"
        puts " - user stick type: #{user_stick.stick.stick_type}"
        puts ""
        
        #pair hits
        @pair_hits = PairHit.where(hit_planed = user_stick.stick.id)
        
        @pair_hits.each do |pair_hit|
        
        @hits_planed = user.hits.where(id = pair_hit.hit_planed)
        @hits_real = user.hits.where(id = pair_hit.hit_real)
        
        
        #meklet katru hit ar hit_planed un hit_real id un reikinat
        
        end
      end
    end
    
  end
  
  
  
  
end
