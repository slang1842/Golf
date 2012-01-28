class SingleFieldStatisticsByHole < ActiveRecord::Base

		belongs_to :single_field_statistic
		belongs_to :field

		def self.check_for_existence(parent_stats)
			field = parent_stats.field
			holes = Hole.where(:field_id => field.id).order("hole_number asc")
			holes.each do |hole|
				stats = SingleFieldStatisticsByHole.where(:field_id)
				conditions = {:hole_number => hole.hole_number, :single_field_statistic_id => parent_stats.id, :field_id => parent_stats.field_id}
				stats = SingleFieldStatisticsByHole.find(:first, :conditions => conditions) || SingleFieldStatisticsByHole.new(conditions)
				stats.check_stats
			end
		end

		def check_stats
			games_on_field = Game.where(:field_id => self.field_id)
			game_id_arr = []
			games_on_field.each {|game| game_id_arr << game.id}
			statusholes = StatusHole.where("status_holes.hole_number = ? AND status_holes.game_id IN(?) AND status_holes.completeness = 2", self.hole_number, game_id_arr).order("updated_at desc")
			if statusholes.first != nil 
				if self.new_record? || statusholes.first.updated_at > self.updated_at
					self.calculate_stats(statusholes)
				end
			end
		end

		def calculate_stats(statusholes)
			self.set_fields_to_zeros
			statusholes.each do |hole|
				hits_non_putts = Hit.where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?) AND hits.place_from NOT IN(?)", hole.game_id, hole.hole_number, ["rp", "penalty_r"], [1])
				hits_putts = Hit.where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?) AND hits.place_from = 1", hole.game_id, hole.hole_number, ["rp", "penalty_r"])
				self.do_the_calculations_already(hits_non_putts.count, hits_putts.count)
			end
			self.avg_strokes = self.total_strokes.to_f / statusholes.count
			self.avg_putts = self.total_putts.to_f / statusholes.count
			self.save!
		end

		def do_the_calculations_already(hits, putts)
			if self.best_strokes > hits then self.best_strokes = hits end
			if self.best_strokes == 999 then self.best_strokes = 0 end
			if self.best_putts > putts then self.best_putts = putts end
			if self.best_putts == 0 then self.best_putts = 0 end
			if self.worst_putts < putts then self.worst_putts = putts end
			if self.worst_strokes < hits then self.worst_strokes = hits end
			self.total_strokes += hits
			self.total_putts += putts
		end

		def set_fields_to_zeros
			self.best_strokes = 999
			self.best_putts = 999
			self.worst_strokes = 0
			self.worst_putts = 0
			self.total_putts = 0
			self.total_strokes = 0 
			self.avg_strokes = 0
			self.avg_putts = 0
		end

end
