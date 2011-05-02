class Statistic < ActiveRecord::Base
  has_many  :users
  has_many  :hits
  
  #scope :get_place_from, lambda { |place| where('place_from = ?', place) }
  
  def self.calculate_current_statistics(p, r) # P = planed, R = Real
    if p == 0
      return "N"
    else
      @result = 0
      @result = 1 - ((r.to_i - p.to_i).abs / p.to_i)
      return @result 
    end
  end
  
  
  def self.calculate_statistics
   
     
  #==============================================
  #==============================================
  3.times { puts "============================================xx" }
  @users = User.all 
  @users.each do |user|
    puts ""
    puts "user_id #{user.id}"
    puts ""
    user.users_sticks.each do |user_stick|
        puts " stick_id #{user_stick.id}"
        
        
        # teebox ==========================================
       
        #global variables
        @all_hits = Hit.where(:user_id => user.id, :stick_id => user_stick.id, :place_from => 1)
       
        #array of all results
        @result_arr = []
        
        #count pairs
        #for i in 1..@all_count / 2 do
        #@PID = PairHit.where(:users_id => user.id, :users_stick.stick_id => user_stick.id)
        @PID = user_stick.pair_hits.all
        
        @PID.each do |each_pair|
        
          #get current loop pair
          #each_pair.each do |p|
          
          puts "  planotais sitiena id: #{each_pair.hit_planed.id }"
          puts "  reala sitiena id: #{each_pair.hit_real.id }"
          
          /
          
            puts "   pair id: {p.id}"
            
            if p.real_hit == "rp"
            @P = p
            puts "    planotais pairhit id { @P.id }"
            elsif p.real_hit == "pp"
            @R = p
            puts "    realais pairhit id { @R.id }"
            end
          /
          end
          puts "------"
        end
        
        
        # teebox ==========================================
    end
      
  end
  puts ""
  
  3.times { puts "============================================xx" }
  #==============================================
  #==============================================
    
  #end
end
