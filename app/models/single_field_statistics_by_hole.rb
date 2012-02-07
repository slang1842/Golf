class SingleFieldStatisticsByHole < ActiveRecord::Base

		belongs_to :single_field_statistic
		belongs_to :field

		def self.check_for_existence(parent_stats, user)
			all_hole_stats = parent_stats.single_field_statistics_by_holes
			parent_stats.field.holes.order("hole_number ASC").each do |hole|
				conditions = {:hole_number => hole.hole_number, :single_field_statistic_id => parent_stats.id, :field_id => parent_stats.field_id}
				stats = all_hole_stats.find(:first, :conditions => conditions) || SingleFieldStatisticsByHole.new(conditions)
				stats.save!
				SingleFieldStatisticsByHole.check_stats(stats, user, parent_stats)
			end
		end

		def self.check_stats(stats, user, parent_stats)
			games_on_field = Game.where(:field_id => stats.field_id)
			game_id_arr = []
			games_on_field.each {|game| game_id_arr << game.id}
			statusholes = StatusHole.where("status_holes.hole_number = ? AND status_holes.game_id IN(?) AND status_holes.completeness = 2", stats.hole_number, game_id_arr).order("updated_at desc")
			SingleFieldStatisticsByHole.calculate_stats(stats, statusholes, user)
			stats.rank = SingleFieldStatisticsByHole.where("hole_number = ? AND field_id = ? AND best_strokes < ?", stats.hole_number, stats.field_id, stats.best_strokes).count.to_i + 1
			stats.save!
			string = "best_score_hole_" + stats.hole_number.to_s
			parent_stats.update_attributes(string.to_sym => stats.best_strokes)
		end

		def self.calculate_stats(stats, statusholes, user)
			stats.best_strokes = 999
			stats.worst_strokes = 0
			stats.total_strokes = 0 
			stats.avg_strokes = 0
			statusholes.each do |hole|
				hits = user.hits.where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?) ", hole.game_id, hole.hole_number, ["rp", "penalty_r"]).count.to_i
				stats.best_strokes = hits if stats.best_strokes > hits && hits != 0
				stats.worst_strokes = hits if stats.worst_strokes < hits 
				stats.total_strokes += hits
				stats.save!
			end
			if stats.best_strokes == 999 then stats.best_strokes = nil end
			stats.avg_strokes = stats.total_strokes.to_f / statusholes.count unless statusholes.count == 0
			stats.save!
		end

end
