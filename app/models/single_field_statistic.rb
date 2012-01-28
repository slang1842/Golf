class SingleFieldStatistic < ActiveRecord::Base

	belongs_to :user
	belongs_to :field
	has_many :single_field_statistic_by_sticks
	has_many :single_field_statistics_by_holes

	def self.calculate_stats
		users = User.where(:is_super_admin => false)
		users.each do |user|
				fields = Field.all
				fields.each do |field|
					games = Game.where(:field_id => field.id)
					if games.any?
						SingleFieldStatistic.check_for_existence(field.id, user.id)
					end
				end
		end
		return true
	end

	def self.check_for_existence(field_id, user_id)
		stats = SingleFieldStatistic.where(:user_id => user_id, :field_id => field_id).first
		if stats != 0
			stats = SingleFieldStatistic.create(:user_id => user_id, :field_id => field_id)
			stats.save!
		end
		SingleFieldStatisticsByHole.check_for_existence(stats)
		SingleFieldStatisticByStick.check_for_existence(stats)
	end

end

	
