class StatisticController < ApplicationController

  
  
  def statistics
  
  
  @users = User.all
  @hits = PairHit.all
  #@sticks = Stick.all
  @new_statistic = Statistic.new

  #each USER
  @users.each do |user|
    #@new_statistic.user_id = user.id
    puts ""
    puts ""
    puts "user id: #{ user.id } "
          
      
      #each STICK
      user.users_sticks.each do |user_sticks|
        #@new_statistic.stick_id = user_sticks.stick.id
        puts " user stick id:  #{user_sticks.stick.id}"

        
          @hits2 = PairHit.where(:user_id => user.id)
          #@hits()
          # each HITS
          @hits2.each do |hits|
            puts "  hits id: #{ hits.id } "
          
          end
        
      
      
      end
  end
  
  
  
  
      
   
  end

end
