class SingleFieldStatisticsByHole < ActiveRecord::Base

		belongs_to :single_field_statistic
		belongs_to :field

		def self.check_for_existence(parent_stats, user, games)
			games_on_field = games.select {|k| k.field_id == parent_stats.field_id}
			game_id_arr = []
			games_on_field.each {|game| game_id_arr << game.id}
			all_statusholes = StatusHole.where(:game_id => game_id_arr)
			parent_stats.field.holes.order("hole_number ASC").each do |hole|
				conditions = {:hole_number => hole.hole_number, :single_field_statistic_id => parent_stats.id, :field_id => parent_stats.field_id}
				stats = parent_stats.single_field_statistics_by_holes.detect {|k| k.hole_number == hole.hole_number && k.single_field_statistic_id == parent_stats.id && k.field_id == parent_stats.field_id}
				stats = SingleFieldStatisticsByHole.create(conditions) if stats == nil
				SingleFieldStatisticsByHole.check_stats(stats, user, parent_stats, all_statusholes)
			end
		end

		def self.check_stats(stats, user, parent_stats, all_statusholes)
			
			statusholes = all_statusholes.select {|k| k.hole_number == stats.hole_number }
			#statusholes = StatusHole.where("status_holes.hole_number = ? AND status_holes.game_id IN(?)", stats.hole_number, game_id_arr).order("updated_at desc")
			SingleFieldStatisticsByHole.calculate_stats(stats, statusholes)
			stats.rank = SingleFieldStatisticsByHole.where("hole_number = ? AND field_id = ? AND best_strokes < ?", stats.hole_number, stats.field_id, stats.best_strokes).count.to_i + 1
			stats.save!
			string = "best_score_hole_" + stats.hole_number.to_s
			string_game = "best_game_hole_" + stats.hole_number.to_s
			parent_stats.update_attributes(string.to_sym => stats.best_strokes)
			parent_stats.update_attributes(string_game.to_sym => stats.best_game)
		end

		def self.calculate_stats(stats, statusholes)
			stats.best_strokes = 999
			stats.worst_strokes = 0
			stats.total_strokes = 0 
			stats.avg_strokes = 0
			best_id = 0
			statusholes.each do |hole|
				hits = hole.total_strokes_count
				if  hits != nil && stats.best_strokes > hits
					stats.best_strokes = hits
					best_id = hole.id
				end
				stats.worst_strokes = hits if hits != nil && stats.worst_strokes < hits
				stats.total_strokes += hits if hits !=  nil
			end
			if best_id != nil
				statushole = StatusHole.find(best_id)
				game = Game.find(statushole.game_id)
				best_string = game.date.strftime("%d.%m.%y.") 
				stats.best_game = best_string
			end
			if stats.best_strokes == 999 then stats.best_strokes = nil end
			stats.avg_strokes = stats.total_strokes.to_f / statusholes.count unless statusholes.count == 0
			stats.save!
		end

end
