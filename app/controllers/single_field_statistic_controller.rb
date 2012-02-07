class SingleFieldStatisticController < ApplicationController
 before_filter :require_user

	def get_stats_remote
		@stats = SingleFieldStatistic.find(params[:stat_id])
		@stats_by_holes = @stats.single_field_statistics_by_holes.order("hole_number asc")
		arr = []
		@stats.user.users_sticks.each {|stick| arr << stick.id }
		@stats_by_sticks = @stats.single_field_statistic_by_sticks.where(:users_stick_id => arr)
		respond_to :js
	end

	def view_total_stats
		@stats = SingleFieldStatistic.where(:field_id => params[:field_id]).order("rank asc").includes("user")
		@user = User.find(params[:user_id])
		respond_to :js
	end

end
