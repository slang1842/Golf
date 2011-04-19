class StatisticController < ApplicationController

  def calculate_statistics
    @all_users = User.all
    
    
    @all_users.each do |user|
      user.users_sticks.each do |stick|
      #puts "====================="
      #puts stick.id
      #/
        Statistics.create (:user_id => user.id
                           :stick_id => stick.id
                           :place_teebox
        )   
      #/
      end
      
    end
    
  end

end
