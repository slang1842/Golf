class SingleFieldStatistic < ActiveRecord::Base

	belongs_to :user
	belongs_to :field
	has_many :single_field_statistic_by_sticks
	has_many :single_field_statistics_by_holes

	def self.calculate_stats(user)
		@single_field_stats = user.single_field_statistics.includes([:single_field_statistic_by_sticks, :single_field_statistics_by_holes])
		field_id_arr = []
		user.games.each {|game| field_id_arr << game.field.id}
		field_id_arr.uniq.each do |field_id|
			SingleFieldStatistic.check_for_existence(field_id, user, @single_field_stats)
		end
		return true
	end

	def self.check_for_existence(field_id, user, all_stats)
		stats = all_stats.where(:user_id => user.id, :field_id => field_id).first
		if stats == nil
			stats = SingleFieldStatistic.create(:user_id => user.id, :field_id => field_id)
			stats.save!
		end
		SingleFieldStatisticsByHole.check_for_existence(stats, user)
		SingleFieldStatisticByStick.check_for_existence(stats, user)		
		stats.save!
		stats.best_total_score = 0
		stats.best_total_score = stats.best_score_hole_1.to_i + stats.best_score_hole_2.to_i + stats.best_score_hole_3.to_i + stats.best_score_hole_4.to_i + stats.best_score_hole_5.to_i + stats.best_score_hole_6.to_i + stats.best_score_hole_7.to_i + stats.best_score_hole_8.to_i + stats.best_score_hole_9.to_i + stats.best_score_hole_10.to_i + stats.best_score_hole_11.to_i + stats.best_score_hole_12.to_i + stats.best_score_hole_13.to_i + stats.best_score_hole_14.to_i + stats.best_score_hole_15.to_i + stats.best_score_hole_16.to_i + stats.best_score_hole_17.to_i + stats.best_score_hole_18.to_i 
		stats.rank = SingleFieldStatistic.where("field_id = ? AND best_total_score < ?", stats.field_id, stats.best_total_score).count.to_i + 1
		stats.save!
	end

end

	
