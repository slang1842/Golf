class StandardStatistic < ActiveRecord::Base

belongs_to :user

def self.calculate_user_stats(user_id)
	statistic = StandardStatistic.find_or_create_by_user_id(user_id)	
	user = User.find(user_id)
		holes = StatusHole.fetch_finished_holes(user_id)
		if holes.any?
			statistic.set_zeros
			game_id_array = []
			holes.each do |hole|
				game_id_array << hole.game_id
				total_strokes = hole.total_strokes_count
				strokes_putts = hole.putts_count
				if total_strokes != nil && strokes_putts != nil
					statistic.total_stroke_count += total_strokes
					statistic.total_putt_count += (strokes_putts)


					#stableford
					par = Hole.fetch_par(hole.game.field_id, hole.hole_number)		
					diff = par - total_strokes
					if diff == 0
						statistic.pars += 1
						sbf = 2
					elsif diff == -1
						statistic.boogies += 1
						sbf = 1
					elsif diff == -2
						statistic.double_boogies += 1
						sbf = 0
					elsif diff > -2
						statistic.others += 1
						sbf = 0
					elsif diff == 1
						statistic.birdies += 1
						sbf = 3
					elsif diff >= 2
						statistic.eagles += 1
						sbf = 4
					else 
						sbf = 0
					end
					statistic.total_stableford += sbf
					statistic.save
					#end of stableford
			
					# GIR
					diff = par - (total_strokes - strokes_putts)
					if diff >= 2
						statistic.total_gir += 1
						statistic.total_gir_putts += strokes_putts
					end
					statistic.save
					#GIR

				end
			end
			game_id_array.uniq!
			statistic.total_game_count = game_id_array.size
			statistic.sbf_avg_per_hole = (statistic.total_stableford.to_f / holes.count)
			statistic.sbf_avg_per_game = (statistic.total_stableford.to_f / game_id_array.size)
			statistic.total_hole_count = holes.count
			statistic.save
			statistic.avg_putts = (statistic.total_putt_count.to_f / statistic.total_hole_count)
			statistic.gir_percentage = ((statistic.total_gir.to_f / statistic.total_hole_count) * 100)
			statistic.gir_putt_ratio = (statistic.total_gir_putts.to_f / statistic.total_gir.to_f) unless statistic.total_gir == 0
			statistic.save!
		end
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
