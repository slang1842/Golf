class StatisticController < ApplicationController

  private
  
  def calculate_statistics
    @all_users = User.all
    @all_hits = Hit.all
      
      #puts "====================="
      #puts @all_hits
    
  end

end
