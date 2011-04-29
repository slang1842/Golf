class Statistic < ActiveRecord::Base
  has_many  :users
  has_many  :hits
  
  #scope :get_place_from, lambda { |place| where('place_from = ?', place) }
  
  def calculate_current_statistics(p, r) # P = planed, R = Real
    if p == 0
      return "N"
    else
      @result = 0
      @result = 1 - ((r.to_i - p.to_i).abs / p.to_i)
      return @result 
    end
  end
  
  
  def self.calculate_statistics
    @users = User.all
    
    #users starts
    @users.each do |user|
    puts " user id: #{user.id}"
    
      #user sticks starts
      user.users_sticks.each do |user_stick|
      puts "  user stick id:#{user_stick.id}"
      
      
      ph_count = PairHit.count
      
        # for i in 1..ph_count.to_i STARTS
        for i in 1..ph_count.to_i
          #puts "   i: #{i}"
          
              #each pair hit starts
              @get_pair_hit = Hit.where(:pair_id => i, :stick_id => user_stick.id)
              @get_pair_hit.each do |get_hit|
                
                puts "     get_pair_hit #{get_hit.id}"
                #-----------------------------
                
                
                
                
                
                
                
                
                
                #-----------------------------
              #each pair hit ends
              end
          
        # for i in 1..ph_count.to_i ENDS
        end
      
      #user sticks ends
      end
    
    
    #users ends
    end
    
  end
end
