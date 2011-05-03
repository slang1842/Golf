class Statistic < ActiveRecord::Base
  has_many  :users
  has_many  :hits
  scope :game, :joins => {:game => :hit}
  scope :stick, :joins => {:stick => :user_stick}
  
  #scope :get_place_from, lambda { |place| where('place_from = ?', place) }
  
  def self.get_average_from_array(arr)
    @result
    
    arr.each do |arre|
      @result = @result + arre
    end
    
    @restult = @result.to_f / arr.size
    return @result
  end
  
  def self.calculate_current_statistics(p, r) # p = planed, r = Real
      #@result = ((1 - ((r.to_f - p.to_f).abs / p.to_f)).round(2) * 100).to_i
      @result = ((1 - ((r.to_f - p.to_f).abs / p.to_f)).round(2) * 100).to_i
      if @result > 100
        return 100
      elsif @result == 0
        return 1
      else
        return @result
      end
  end
  
  
def self.calculate_statistics

  3.times { puts "============================================xx" }
  
  
  @users = User.all 
  @users.each do |user|
    puts ""
    puts "user_id #{user.id}"
    puts ""
    user.users_sticks.each do |user_stick|
        puts " stick_id #{user_stick.stick.id}"
        
        #CALCULATE PLACE_FROM
        # ==========================================
        for place_from_num in 1..11 do
          @all_pairs = PairHit.where(:users_id => user.id)
          
          @result_arr = []
        
          @all_pairs.each do |each_pair|
            if each_pair.hit_planed.place_from == place_from_num && each_pair.hit_planed.stick_id == user_stick.stick.id
               @result_arr.push(calculate_current_statistics(each_pair.hit_planed.hit_distance, each_pair.hit_real.hit_distance))
            end
          end
         
         
          case place_from_num 
            when 1
              if @result_arr.size != 0
                puts "    place from: Teebox: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 2
              if @result_arr.size != 0
                puts "    place from: Feairway: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 3
              if @result_arr.size != 0
                puts "    place from: Next fairway: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 4
              if @result_arr.size != 0
                puts "    place from: Semi raf: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 5
              if @result_arr.size != 0
                puts "    place from: Raf: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 6
              if @result_arr.size != 0
                puts "    place from: For green: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 7
              if @result_arr.size != 0
                puts "    place from: Green: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 8
              if @result_arr.size != 0
                puts "    place from: Fairway sand: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 9
              if @result_arr.size != 0
                puts "    place from: Green sand: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 11
              if @result_arr.size != 0
                puts "    place from: Wood: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
            when 11
              if @result_arr.size != 0
                puts "    place from: From water: #{(@result_arr.inject(0.0) { |sum, el| sum + el } / @result_arr.size).to_i}%"
                puts "   ---"
              end
          end
        end
        # ==========================================
        
        
        
      end
    end
  puts ""
  3.times { puts "============================================xx" }
  end
  

  
  def calculate_place_from
    case place_from_num 
      when 1
      puts "    Teebox"
      when 2
      puts "    Feairway"
      when 3
        puts "    Next fairway"
      when 4
        puts "    Semi raf"
      when 5
        puts "    Raf"
      when 6
        puts "    For green"
      when 7
        puts "    Green"
      when 8
        puts "    Fairway sand"
      when 9
        puts "    Green sand"
      when 11
        puts "    Wood"
      when 11
        puts "    From water"
    end
  end
end