class SingleFieldStatistic < ActiveRecord::Base

	belongs_to :user
	belongs_to :field
	has_many :single_field_statistic_by_sticks
	has_many :single_field_statistics_by_holes

	def self.calculate_stats(user)
		@single_field_stats = user.single_field_statistics.includes([:single_field_statistic_by_sticks, :single_field_statistics_by_holes])
		field_id_arr []
		user.games.each {|game| field_id_arr << game.field.id}
		field_id_arr.uniq.each do |field_id|
			SingleFieldStatistic.check_for_existence(field_id, user, @single_field_stats)
		end
		return true
	end

	def self.check_for_existence(field_id, user, all_stats)
		stats = all_stats.where(:user_id => user.id, :field_id => field_id).first
		if stats == nil
			stats = SingleFieldStatistic.create(:user_id => user_id, :field_id => field_id)
			stats.save!
		end
		SingleFieldStatisticsByHole.check_for_existence(stats, user)
		SingleFieldStatisticByStick.check_for_existence(stats, user)
	end

end

	
