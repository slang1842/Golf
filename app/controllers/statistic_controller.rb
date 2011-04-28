class StatisticController < ApplicationController

  
  
  def statistics
    Statistic.calculate_statistics
  end
    

end
