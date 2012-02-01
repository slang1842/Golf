class StandardStatistic < ActiveRecord::Base

belongs_to :user

def self.calculate_user_stats(user_id)
	statistic = StandardStatistic.find_or_create_by_user_id(user_id)	
	user = User.find(user_id)
	last_hole = StatusHole.fetch_last_hole(user_id)
#	if last_hole != false && (statistic.new_record? || last_hole.updated_at > statistic.updated_at)
		holes = StatusHole.fetch_finished_holes(user_id)
		if holes.any?
			statistic.set_zeros
			game_id_array = []
			holes.each do |hole|
				game_id_array << hole.game_id
				strokes_non_putts = hole.hits.where(:real_hit => ['rp', 'penalty_r'])
				strokes_putts = hole.hits.where(:real_hit => ['pp', 'penalty'])
				if strokes_non_putts.any? && strokes_putts.any?
					statistic.total_stroke_count += (strokes_non_putts.count + strokes_putts.count)
					statistic.total_putt_count += (strokes_putts.count)
					par = Hole.fetch_par(hole.game.field_id, hole.hole_number)
			
					statistic.calculate_stableford(statistic.total_stroke_count, par, user.hcp.to_i)
					statistic.calculate_GIR(par, user.hcp.to_i, strokes_non_putts.count, strokes_putts.count)
				end
			end
			game_id_array.uniq!
			statistic.total_game_count = game_id_array.size
			statistic.sbf_avg_per_hole = (statistic.total_stableford.to_f / holes.count)
			statistic.sbf_avg_per_game = (statistic.total_stableford.to_f / holes.count)
			statistic.total_hole_count = holes.count
			statistic.save
			statistic.avg_putts = (statistic.total_putt_count.to_f / statistic.total_hole_count)
			statistic.gir_percentage = ((statistic.total_gir.to_f / statistic.total_hole_count) * 100)
			statistic.gir_putt_ratio = (statistic.total_gir_putts.to_f / statistic.total_gir.to_f) unless statistic.total_gir == 0
			statistic.save!
		end

end

def calculate_stableford(total_strokes, par, hcp)
	diff = par + hcp - total_strokes
	if diff == 0
		self.pars += 1
		sbf = 2
	elsif diff == -1
		self.boogies += 1
		sbf = 1
	elsif diff == -2
		self.double_boogies += 1
		sbf = 0
	elsif diff > -2
		self.others += 1
		sbf = 0
	elsif diff == 1
		self.birdies += 1
		sbf = 3
	elsif diff >= 2
		self.eagles += 1
		sbf = 4
	else 
		sbf = 0
	end
	self.total_stableford += sbf
	self.save
end

def calculate_GIR(par, hcp, strokes_non_putts, strokes_putts)
	diff = par + hcp - strokes_non_putts
	if diff >= 2
		self.total_gir += 1
		self.total_gir_putts += strokes_putts
	end
	self.save
end

def set_zeros
		self.total_stroke_count = 0
		self.total_putt_count = 0
		self.total_game_count = 0
		self.sbf_avg_per_hole = 0
		self.sbf_avg_per_game = 0
		self.total_hole_count = 0
		self.avg_putts = 0
		self.gir_percentage = 0
		self.gir_putt_ratio = 0
		self.pars = 0 
		self.boogies = 0
		self.double_boogies = 0
    self.others = 0
    self.eagles = 0
		self.birdies = 0
		self.total_stableford = 0
		self.total_gir = 0
		self.total_gir_putts = 0
end
	
end
