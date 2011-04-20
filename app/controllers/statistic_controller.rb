class StatisticController < ApplicationController

  
  
  def statistics
  
  
  @users = User.all
  #@hits = PairHit.all
  #@sticks = Stick.all
  @new_statistic = Statistic.new

  #each USER
  @users.each do |user|
    #@new_statistic.user_id = user.id
    puts ""
    puts ""
    puts "========="
    puts "user id: "
    puts  user.id
    
      
      
      #each STICK
      user.users_sticks.each do |user_sticks|
        #@new_statistic.stick_id = user_sticks.stick.id
        puts "user stick: "
        puts user_sticks.stick.id
        puts "-------"

        
          #@hits2 = @hits.find(:all, :conditions => {:user_id => user.id, :stick_id => users_sticks.id})
          #@hits()
          # each HITS
          @hits.each do |hits|
          
          
          end
        
      
      
      end
  end
  
  
  
  
      
   
  end

end
