class StatisticController < ApplicationController

 
  def statistics
    if Statistic.calculate_statistics
      redirect_to show_statistic_path
    else
      
    end
  end
    
  def show
    @statistic = Statistic.find(:all)
  end
end
