class Hit < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :field
  belongs_to :hole
	belongs_to :status_hole
  
  #belongs_to :PairHit
  #belongs_to :hit_planed, :class => 'PairHit', :foreign_key => 'hit_planed_id'
  #belongs_to :hit_real, :class => 'PairHit', :foreign_key => 'hit_real_id'
  belongs_to :stick
  has_many :PairHit
  has_many :hit_planed, :class_name => 'PairHit', :foreign_key => 'hit_planed_id'
  has_many :hit_real, :class_name => 'PairHit', :foreign_key => 'hit_real_id'
 
	scope :non_putts, lambda{ |game_id, hole_number| where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?) AND hits.place_from NOT IN(?)", game_id, hole_number, ["pp", "penalty"], [1])}
	scope :putts, lambda{ |game_id, hole_number| where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?) AND hits.place_from = ?", game_id, hole_number, ["pp", "penalty"], 1)}

		

	def self.fetch_real_prev(active_hole, active_hit, hits)
		hit = hits.detect {|h| h.hole_number.to_i == active_hole.to_i && h.hit_number.to_i == (active_hit.to_i - 1) && (h.real_hit.to_s == 'rp' || h.real_hit.to_s == 'penalty_r')}
		return hit
	end

	def self.fetch_planned_prev(active_hole, active_hit, hits)
		hit = hits.detect {|h| h.hole_number.to_i == active_hole.to_i && h.hit_number.to_i == (active_hit.to_i - 1) && (h.real_hit.to_s == 'pp' || h.real_hit.to_s == 'penalty')}
		return hit
	end
	
	def self.fetch_real(active_hole, active_hit, hits)
		hit = hits.detect { |h| h.hole_number.to_i == active_hole.to_i && h.hit_number.to_i == active_hit.to_i && (h.real_hit.to_s == 'rp' || h.real_hit.to_s == 'penalty_r')}
		puts "here"
		puts hit.id
		puts "see?"
		return hit
	end

	
	def self.fetch_planned(active_hole, active_hit, hits)   
		hit = hits.detect {|h| h.hole_number.to_i == active_hole.to_i && h.hit_number.to_i == active_hit.to_i && (h.real_hit.to_s == 'pp' || h.real_hit.to_s == 'penalty')} 
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



	def self.remove_penalty(game_id, active_hit, hole_number)
		hit_real = Hit.where(:game_id => game_id, :hit_number => active_hit, :hole_number => hole_number, :real_hit => 'penalty_r').first
		hit_planned = Hit.where(:game_id => game_id, :hit_number => active_hit, :hole_number => hole_number, :real_hit => 'penalty').first
		hit_real.update_attributes(:real_hit => "rp")
		hit_planned.update_attributes(:real_hit => "pp")
	end

	def self.create_penalty(game_id, active_hit, hole_number)
		hit_real = Hit.where(:game_id => game_id, :hit_number => active_hit.to_i, :hole_number => hole_number, :real_hit => 'rp').first
		hit_real_prev = Hit.where(:game_id => game_id, :hit_number => (active_hit.to_i - 1), :hole_number => hole_number, :real_hit => ['rp','penalty_r']).first
		hit_planned = Hit.where(:game_id => game_id, :hit_number => active_hit.to_i, :hole_number => hole_number, :real_hit => 'pp').first
		hit_planned_prev = Hit.where(:game_id => game_id, :hit_number => (active_hit.to_i - 1), :hole_number => hole_number, :real_hit => ['pp', 'penalty']).first
		idr = hit_real.id
		idp = hit_planned.id
		hit_real.attributes = hit_real_prev.attributes
		hit_planned.attributes = hit_planned_prev.attributes
		hit_real.update_attributes(:real_hit => 'penalty_r', :id => idr, :hit_number => active_hit.to_i)
		hit_planned.update_attributes(:real_hit => 'penalty', :id => idp, :hit_number => active_hit.to_i)
		hit_real.save!
		hit_planned.save!
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

	def self.render_hits_anew(game_id)
		game = Game.includes("status_holes").includes("hits").includes("pair_hits").find(game_id)
		all_hits = game.hits
		all_pair_hits = game.pair_hits
		game.status_holes.each do |hole|
			planned_hits = all_hits.select {|h| h.hole_number == hole.hole_number && h.real_hit == 'p'}
			if planned_hits == nil || planned_hits.count != hole.total_strokes_count
				Hit.render_planned_hits(game, hole, all_hits)
			end
			real_hits = all_hits.select {|h| h.hole_number == hole.hole_number && (h.real_hit == 'rp' || h.real_hit == 'penalty_r')}
			if real_hits == nil || real_hits.count != hole.total_strokes_count
				Hit.render_real_hits(game, hole, all_hits, all_pair_hits)
			end
		end
	end

	def self.render_planned_hits(game, hole, all_hits)
		planned_hits = all_hits.select {|h| h.hole_number == hole.hole_number && h.real_hit == 'p'}
		if planned_hits != nil then planned_hits.each {|h| h.destroy} end
		i = 1
		while hole.total_strokes_count >= i
			hit = Hit.new(:game_id => game.id, :user_id => game.user_id, :hole_number => hole.hole_number, :hit_number => i, :real_hit => 'p')
			if i == 1 then hit.place_from = 2 end
			if i == hole.total_strokes_count then hit.land_place = 11 end
			hit.save!
			i += 1
		end   
	end

	def self.render_real_hits(game, hole, all_hits, all_pair_hits)
		real_hits = all_hits.select {|h| h.hole_number == hole.hole_number && (h.real_hit == 'rp' || h.real_hit == 'penalty_r')}
		real_hits.each do |rhit|
			pair = all_pair_hits.detect {|p| p.hit_real_id == rhit.id}
			phit = all_hits.detect {|h| h.id == pair.hit_planed_id }
			rhit.destroy
			phit.destroy
			pair.destroy
		end
		i = 1
		while hole.total_strokes_count >= i
			rhit = Hit.new(:game_id => game.id, :user_id => game.user_id, :hole_number => hole.hole_number, :hit_number => i, :real_hit => 'rp')
			phit = Hit.new(:game_id => game.id, :user_id => game.user_id, :hole_number => hole.hole_number, :hit_number => i, :real_hit => 'pp')
			if i == 1
				rhit.place_from = 2
				phit.place_from = 2
			end
			if i == hole.total_strokes_count
				rhit.land_place = 11
				phit.land_place = 11
			end
			rhit.save!
			phit.save!
			pair = PairHit.create(:hit_real_id => rhit.id, :hit_planed_id => phit.id, :user_id => game.user_id, :game_id => game.id)
			pair.save!
			i += 1
		end
	end

	def self.check_for_differences(game_id)
		game = Game.includes("status_holes").includes("hits").includes("pair_hits").find(game_id)
		all_hits = game.hits
		all_pair_hits = game.pair_hits
		game.status_holes.each do |hole|
			real_hits = all_hits.select {|h| h.hole_number == hole.hole_number && (h.real_hit == 'rp' || h.real_hit == 'penalty_r')}
			if real_hits == nil || real_hits.count != hole.total_strokes_count
				Hit.render_real_hits(game, hole, all_hits, all_pair_hits)
			end
		end
	end
	
	def self.check_for_plan_differences(game_id)
		game = Game.includes("status_holes").includes("hits").includes("pair_hits").find(game_id)
		all_hits = game.hits
		game.status_holes.each do |hole|
			real_hits = all_hits.select {|h| h.hole_number == hole.hole_number && h.real_hit == 'p' }
			if real_hits == nil || real_hits.count != hole.total_strokes_count
				Hit.render_planned_hits(game, hole, all_hits)
			end
		end
	end

end
