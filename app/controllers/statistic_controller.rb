class StatisticController < ApplicationController

  
  
  def statistics
    @users = User.all
        
    puts "======================"
    
    #users
    @users.each do |user|
      puts ""
      puts "user id: #{user.id}"
      puts "user name: #{user.first_name}"
      puts ""
      /
      #users sticks
        user.users_sticks.each do |user_stick|
          puts " - user stick id: {user_stick.id}"
          puts " - user stick type: {user_stick.stick.stick_type}"
          puts ""
          /
          #pair hits
          #@PH = PairHit.where(user_id = user.id)
          
          #@PH.each do |PH|
          
          #  @P = PH.hit_planed
          #  @R = PH.hit_real
          #  result = 0
          #  how_many = 0
          #end
          
          
          #dabut visus parisus ar place_from = x (teebox, green)
          #@get_place_from = Hit.get_place_from("Teebox")
          
          @get_place_from = Hit.get_place_from("Teebox")
          
          @get_place_from.each do |x|
            puts x.hit_distance
          end
        
        puts ""
        puts "----------------------"
        
        
        
          
          #@place_teebox = calculate_current_statistics(P, R)
          
        
        end
        
        
        #statisticas reikinasana
        #calculate_current_statistics
        
        #meklet katru hit ar hit_planed un hit_real id un reikinat
        
        
      
    end
    

  end
