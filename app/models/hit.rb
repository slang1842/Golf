class Hit < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :field
  belongs_to :hole
  
  #belongs_to :PairHit
  #belongs_to :hit_planed, :class => 'PairHit', :foreign_key => 'hit_planed_id'
  #belongs_to :hit_real, :class => 'PairHit', :foreign_key => 'hit_real_id'
  belongs_to :stick
  has_many :PairHit
  has_many :hit_planed, :class_name => 'PairHit', :foreign_key => 'hit_planed_id'
  has_many :hit_real, :class_name => 'PairHit', :foreign_key => 'hit_real_id'
 
	scope :non_putts, lambda{ |game_id, hole_number| where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?) AND hits.place_from NOT IN(?)", game_id, hole_number, ["pp", "penalty"], [1])}
	scope :putts, lambda{ |game_id, hole_number| where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?) AND hits.place_from = ?", game_id, hole_number, ["pp", "penalty"], 1)}

		def self.remove_detailed_hit(active_hit, game_id, hole_number)
			@hits = Hit.where("hits.game_id = ? AND hits.hit_number = ? AND hits.real_hit IN(?) AND hits.hole_number = ?", game_id, active_hit.to_i, ["pp", "rp", "penalty", "penalty_r"], hole_number)
			if @hits.any?
				@hits.each do |hit|
					pair = PairHit.where("pair_hits.hit_planed_id = ? OR pair_hits.hit_real_id = ?", hit.id, hit.id)
					if pair then pair.each {|p| p.destroy} end
			  	hit.destroy
				end
				altered_hits = Hit.where("hits.game_id = ? AND hits.hit_number > ? AND hits.real_hit IN(?) AND hits.hole_number = ?", game_id, active_hit.to_i, ["pp", "rp", "penalty", "penalty_r"], hole_number).order("hits.hit_number asc")
				if altered_hits.any?
					i = active_hit.to_i
					hit_number = active_hit.to_i
					altered_hits.each do |hit|
						hit.update_attributes(:hit_number => i)
						i += 1
					end
				else
					hit_number = active_hit.to_i - 1 
		  	end
			end
			return hit_number
		end


	def self.fetch_real_prev(active_hole, active_hit, game_id, user_id)
		conditions6 = { :game_id => game_id, 
               :hole_number => active_hole,
               :hit_number => active_hit.to_i - 1, 
               :real_hit => 'rp',
               :user_id => user_id}
		hit = Hit.find(:first, :conditions => conditions6)
		if hit == nil	then hit = Hit.search_for_penalties(active_hole, (active_hit.to_i - 1), game_id, user_id, "penalty_r") end
		return hit
	end

	def self.fetch_planned_prev(active_hole, active_hit, game_id, user_id)
		 conditions5 = {:game_id => game_id, 
               :hole_number => active_hole,
               :hit_number => active_hit.to_i - 1, 
               :real_hit => 'pp',
               :user_id => user_id
                 }
		hit = Hit.find(:first, :conditions => conditions5)
		if hit == nil	then hit = Hit.search_for_penalties(active_hole, (active_hit.to_i - 1), game_id, user_id, "penalty") end
		return hit
	end
	
	def self.fetch_real(active_hole, active_hit, game_id, user_id)
		  conditions2 = { :game_id => game_id, 
               :hole_number => active_hole,
               :hit_number => active_hit, 
               :real_hit => 'rp',
               :user_id => user_id}
		hit = Hit.find(:first, :conditions => conditions2)
		if hit == nil
			hit = Hit.search_for_penalties(active_hole, active_hit, game_id, user_id, "penalty")		
			if hit == nil
				hit = Hit.create(conditions2)
			end
		end
		return hit
	end
	
	def self.fetch_planned(active_hole, active_hit, game_id, user_id)
		conditions1 = { :game_id => game_id, 
               :hole_number => active_hole,
               :hit_number => active_hit, 
               :real_hit => 'pp',
               :user_id => user_id
               }     
		hit = Hit.find(:first, :conditions => conditions1) 
		if hit == nil
			hit = Hit.search_for_penalties(active_hole, active_hit, game_id, user_id, "penalty_r")		
			if hit == nil
				hit = Hit.create(conditions1)
			end
		end
		return hit
	end

	def self.convert_to_m(hit, measurement)
			hit_distance = hit.hit_distance 
			distance_to_hole = hit.distance_to_hole 
      hit.hit_distance = Stick.convert_distance_to_meters(measurement, hit_distance) if hit_distance
      hit.distance_to_hole = Stick.convert_distance_to_meters(measurement, distance_to_hole) if distance_to_hole
    	hit.save!

  end

	def self.convert_from_m(hit, measurement)
			hit_distance = hit.hit_distance 
			distance_to_hole = hit.distance_to_hole 
      hit.hit_distance = Stick.convert_distance_from_meters(measurement, hit_distance) if hit_distance
      hit.distance_to_hole = Stick.convert_distance_from_meters(measurement, distance_to_hole) if distance_to_hole
			hit.save!

  end

	def self.fetch_final_real(game_id, active_hole, active_hit, user_id)
		conditions1 = { :game_id => game_id, 
               :hole_number => active_hole,
               :hit_number => active_hit, 
               :real_hit => 'rp',
               :user_id => user_id
               }
		hit = Hit.find(:first, :conditions => conditions1)
			if hit == nil	then hit = Hit.search_for_penalties(active_hole, active_hit, game_id, user_id, "penalty_r") end
			if hit == nil then hit = Hit.create(conditions1) end
		return hit
	end

	def self.fetch_final_planned(game_id, active_hole, active_hit, user_id)
		conditions2 = { :game_id => game_id, 
   		         :hole_number => active_hole,
               :hit_number => active_hit, 
               :real_hit => 'pp',
               :user_id => user_id}
		hit = Hit.find(:first, :conditions => conditions2)
		if hit == nil	then hit = Hit.search_for_penalties(active_hole, active_hit, game_id, user_id, "penalty") end
		if hit == nil then hit = Hit.create(conditions2) end
		return hit
	end

	def self.create_penalty(game_id, active_hit, hole_number)
		hit_real = Hit.where(:game_id => game_id, :hit_number => active_hit, :hole_number => hole_number, :real_hit => 'rp').first
		hit_planned = Hit.where(:game_id => game_id, :hit_number => active_hit, :hole_number => hole_number, :real_hit => 'pp').first
		hit_real_prev = Hit.where(:game_id => game_id, :hit_number => (active_hit.to_i - 1), :hole_number => hole_number, :real_hit => 'rp').first
		hit_planned_prev = Hit.where(:game_id => game_id, :hit_number => (active_hit.to_i - 1), :hole_number => hole_number, :real_hit => 'pp').first
		penalty_p = hit_planned_prev.clone
		penalty_p.hit_number = hit_planned.hit_number
		penalty_p.real_hit = "penalty"
		penalty_r = hit_real_prev.clone
		penalty_r.hit_number = hit_planned.hit_number
		penalty_r.real_hit = "penalty_r"
		penalty_p.save
		penalty_r.save
		pair = PairHit.where("pair_hits.hit_planed_id = ? OR pair_hits.hit_real_id = ?", hit_real.id, hit_real.id).first
		pair.destroy
		hit_real.destroy
		hit_planned.destroy
		pair_new = PairHit.create({:hit_planed_id => penalty_p.id, :hit_real_id => penalty_r.id, :game_id => penalty_p.game_id, :user_id => penalty_p.user_id})
		pair_new.save
	end

	def self.remove_penalty(game_id, active_hit, hole_number)
		hit_real = Hit.where(:game_id => game_id, :hit_number => active_hit, :hole_number => hole_number, :real_hit => 'penalty_r').first
		hit_planned = Hit.where(:game_id => game_id, :hit_number => active_hit, :hole_number => hole_number, :real_hit => 'penalty').first
		hit_real.update_attributes(:real_hit => "rp")
		hit_planned.update_attributes(:real_hit => "pp")
	end

	def self.search_for_penalties(active_hole, active_hit, game_id, user_id, real_hit)
		conditions = { :game_id => game_id, 
   		         :hole_number => active_hole,
               :hit_number => active_hit, 
               :real_hit => real_hit,
               :user_id => user_id}
		hit = Hit.find(:first, :conditions => conditions)
		return hit
	end


end
