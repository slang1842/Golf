class StatisticController < ApplicationController

  def calculate_statistics
    @all_users = User.all
    
    
    
    puts '================================'
    puts @all_users
  end

end
