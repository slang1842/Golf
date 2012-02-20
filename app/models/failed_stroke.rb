class FailedStroke < ActiveRecord::Base

	belongs_to :statistic
	belongs_to :user	
	belongs_to :stick

	def self.calculate_and_update(other_stats_id, user_id, all_failed_strokes, stick_id, stats_id, current_strokes, position_name)
			clipboard = current_strokes.clone
			FailedStroke.ressurect_and_update(user_id, all_failed_strokes, 999, other_stats_id, clipboard, position_name)
		failed_strokes = all_failed_strokes.detect { |k| k.stick_id == stick_id && k.position_name == position_name && k.statistic_id == stats_id && k.user_id == user_id }
		if failed_strokes == nil
			failed_strokes = FailedStroke.create(:stick_id => stick_id, :position_name => position_name, :statistic_id => stats_id, :user_id => user_id)
		end
		if current_strokes[:total_strokes] != 0
			total = current_strokes[:total_strokes]
			#current_strokes[:top_strokes] = calculate_avg(current_strokes[:top_strokes], total)
			#current_strokes[:under_strokes] = calculate_avg(current_strokes[:under_strokes], total)
			#current_strokes[:long_strokes] = calculate_avg(current_strokes[:long_strokes], total) 
			#current_strokes[:short_strokes] = calculate_avg(current_strokes[:short_strokes], total)
			#current_strokes[:left_strokes] = calculate_avg(current_strokes[:left_strokes], total)
			#current_strokes[:more_left_strokes] = calculate_avg(current_strokes[:more_left_strokes], total)
			#current_strokes[:right_strokes] = calculate_avg(current_strokes[:right_strokes], total)
			#current_strokes[:more_right_strokes] = calculate_avg(current_strokes[:more_right_strokes], total)
			#current_strokes[:ok_strokes] = calculate_avg(current_strokes[:ok_strokes], total)
			#current_strokes[:penalty_strokes] = calculate_avg(current_strokes[:penalty_strokes], total)
		end
		failed_strokes.update_attributes(current_strokes)
		failed_strokes.save!
	end

	def self.calculate_avg(total_sum, total_count)
		if total_count == nil 
		 	percentage = 0.01
		else	 
			percentage = total_sum.to_f / total_count.to_f
		end	
		 percentage = percentage * 100				
		 return percentage.round
	end

	def self.ressurect_and_update(user_id, all_failed_strokes, stick_id, stats_id, current_strokes, position_name)
		failed_strokes = all_failed_strokes.detect { |k| k.stick_id == stick_id && k.position_name == position_name && k.statistic_id == stats_id && k.user_id == user_id }
		if failed_strokes == nil
			failed_strokes = FailedStroke.create(:stick_id => stick_id, :position_name => position_name, :statistic_id => stats_id, :user_id => user_id, :top_strokes => 0, :under_strokes => 0, :long_strokes => 0, :left_strokes => 0, :more_left_strokes => 0, :right_strokes => 0, :more_right_strokes => 0, :ok_strokes => 0, :total_strokes => 0, :short_strokes => 0, :penalty_strokes => 0)
		end

		if current_strokes[:total_strokes] != 0
		if failed_strokes.total_strokes != nil || failed_strokes.total_strokes != 0
			total_fail = failed_strokes.total_strokes.to_f
		current_strokes[:top_strokes] += (failed_strokes.top_strokes.to_f * total_fail * 0.01 ) if failed_strokes.top_strokes != nil
			current_strokes[:under_strokes] += (failed_strokes.under_strokes.to_f * total_fail * 0.01) if failed_strokes.under_strokes != nil
			current_strokes[:long_strokes] += (failed_strokes.long_strokes.to_f * total_fail * 0.01) if failed_strokes.long_strokes != nil
			current_strokes[:short_strokes] += (failed_strokes.short_strokes.to_f * total_fail * 0.01) if failed_strokes.short_strokes != nil
			current_strokes[:left_strokes] += (failed_strokes.left_strokes.to_f * total_fail * 0.01) if failed_strokes.left_strokes != nil
			current_strokes[:more_left_strokes] += (failed_strokes.more_left_strokes.to_f * total_fail * 0.01) if failed_strokes.more_left_strokes != nil
			current_strokes[:right_strokes] += (failed_strokes.right_strokes.to_f * total_fail * 0.01) if failed_strokes.right_strokes != nil
			current_strokes[:more_right_strokes] += (failed_strokes.more_right_strokes.to_f * total_fail * 0.01) if failed_strokes.more_right_strokes != nil
			current_strokes[:ok_strokes] += (failed_strokes.ok_strokes.to_f * total_fail * 0.01) if failed_strokes.ok_strokes != nil
			current_strokes[:penalty_strokes] += (failed_strokes.penalty_strokes.to_f * total_fail * 0.01) if failed_strokes.penalty_strokes != nil
			current_strokes[:total_strokes] += total_fail
		end
		
			total = current_strokes[:total_strokes]
			current_strokes[:top_strokes] = calculate_avg(current_strokes[:top_strokes], total)
			current_strokes[:under_strokes] = calculate_avg(current_strokes[:under_strokes], total)
			current_strokes[:long_strokes] = calculate_avg(current_strokes[:long_strokes], total) 
			current_strokes[:short_strokes] = calculate_avg(current_strokes[:short_strokes], total)
			current_strokes[:left_strokes] = calculate_avg(current_strokes[:left_strokes], total)
			current_strokes[:more_left_strokes] = calculate_avg(current_strokes[:more_left_strokes], total)
			current_strokes[:right_strokes] = calculate_avg(current_strokes[:right_strokes], total)
			current_strokes[:more_right_strokes] = calculate_avg(current_strokes[:more_right_strokes], total)
			current_strokes[:ok_strokes] = calculate_avg(current_strokes[:ok_strokes], total)
			current_strokes[:penalty_strokes] = calculate_avg(current_strokes[:penalty_strokes], total)				
			failed_strokes.update_attributes(current_strokes)
			failed_strokes.save
		end
	
	end



	def self.calculate_and_update_for_single(failed_strokes, current_strokes)
		
		if current_strokes[:total_strokes] != 0
			total = current_strokes[:total_strokes]
			current_strokes[:top_strokes] = calculate_avg(current_strokes[:top_strokes], total)
			current_strokes[:under_strokes] = calculate_avg(current_strokes[:under_strokes], total)
			current_strokes[:long_strokes] = calculate_avg(current_strokes[:long_strokes], total) 
			current_strokes[:short_strokes] = calculate_avg(current_strokes[:short_strokes], total)
			current_strokes[:left_strokes] = calculate_avg(current_strokes[:left_strokes], total)
			current_strokes[:more_left_strokes] = calculate_avg(current_strokes[:more_left_strokes], total)
			current_strokes[:right_strokes] = calculate_avg(current_strokes[:right_strokes], total)
			current_strokes[:more_right_strokes] = calculate_avg(current_strokes[:more_right_strokes], total)
			current_strokes[:ok_strokes] = calculate_avg(current_strokes[:ok_strokes], total)
			current_strokes[:penalty_strokes] = calculate_avg(current_strokes[:penalty_strokes], total)
		end
		failed_strokes.update_attributes(current_strokes)
		failed_strokes.save!
	end


end
