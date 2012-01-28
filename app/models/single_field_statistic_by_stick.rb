class SingleFieldStatisticByStick < ActiveRecord::Base

	belongs_to :single_field_statistic
	belongs_to :field
	belongs_to :users_stick
	
	def self.check_for_existence(stats)
		stats.user.users_sticks.each do |stick|
			conditions = {:single_field_statistic_id => stats.id, :field_id => stats.field_id, :users_stick_id => stick.id}
			stick_stats = SingleFieldStatisticByStick.find(:first, :conditions => conditions) || SingleFieldStatisticByStick.new(conditions)
			stick_stats.check_stats
			stick_stats.save!
		end
	end

	def check_stats
		games_on_field = Game.where(:field_id => self.field_id)
		game_id_arr = []
		games_on_field.each {|game| game_id_arr << game.id}
		hits = Hit.where("hits.game_id IN(?) AND hits.stick_id = ? AND hits.real_hit IN(?)", game_id_arr, self.users_stick.stick.id, ["rp", "penalty_r"]).order("hits.updated_at desc")
		if hits.any?
			if self.new_record? || hits.first.updated_at > self.updated_at
				self.calculate_stats(hits)
			end
		end	
	end

	def calculate_stats(hits)
		self.set_to_zeros
		self.total_strokes = hits.count
		hits.each {|hit| self.total_distance += hit.hit_distance.to_i}
		self.avg_distance = self.total_distance.to_f / self.total_strokes
		self.save
	end

	def set_to_zeros
		self.total_strokes = 0
		self.total_distance = 0
		self.avg_distance = 0
	end

end
