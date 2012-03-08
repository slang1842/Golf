class SingleFieldStatisticByStick < ActiveRecord::Base

	belongs_to :single_field_statistic
	belongs_to :field
	belongs_to :users_stick
	
	def self.check_for_existence(stats, user)
		all_stick_stats = stats.single_field_statistic_by_sticks
		user.users_sticks.each do |stick|
			conditions = {:single_field_statistic_id => stats.id, :field_id => stats.field_id, :users_stick_id => stick.id}
			stick_stats = all_stick_stats.detect {|k| k.single_field_statistic_id == stats.id && k.field_id == stats.field_id && k.users_stick_id == stick.id} || SingleFieldStatisticByStick.create(conditions)
			SingleFieldStatisticByStick.check_stats(stick_stats, user)
			stick_stats.save!
		end
	end

	def self.check_stats(stick_stats, user)
		games_on_field = user.games.where(:field_id => stick_stats.field_id)
		game_id_arr = []
		games_on_field.each {|game| game_id_arr << game.id}
		hits = user.hits.where("hits.game_id IN(?) AND hits.stick_id = ? AND hits.real_hit IN(?)", game_id_arr, stick_stats.users_stick.stick.id, ["rp", "penalty_r"]).order("hits.updated_at desc")
		if hits.any?
			if stick_stats.new_record? || hits.first.updated_at > stick_stats.updated_at
				stick_stats.total_strokes = 0
				stick_stats.total_distance = 0
				stick_stats.avg_distance = 0
				stick_stats.set_to_zeros
				stick_stats.total_strokes = hits.count
				hits.each {|hit| stick_stats.total_distance += hit.hit_distance.to_i}
				stick_stats.avg_distance = stick_stats.total_distance.to_f / stick_stats.total_strokes.to_f unless stick_stats.total_strokes == 0
				stick_stats.save
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
