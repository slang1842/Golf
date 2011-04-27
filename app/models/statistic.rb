class Statistic < ActiveRecord::Base
  has_many  :users
  has_many  :hits
  
  #scope :get_place_from, lambda { |place| where('place_from = ?', place) }
  
  def calculate_current_statistics(P, R) # P = planed, R = Real
    if P = 0
      return "N"
    else
      @result = 0
      @result = 1 - ((R - P).abs / P)
      return @result 
    end
  end
  
  def calculate_user_statistics
    
  
  
  end
  
  
end
