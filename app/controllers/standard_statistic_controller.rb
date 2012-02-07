class StandardStatisticController < ApplicationController
 before_filter :require_user
	
def index
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("gir_percentage desc")
end

def gir
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("gir_percentage desc").includes("user")
end

def putts
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("avg_putts desc").includes("user")
end

def stableford
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("sbf_avg_per_hole desc").includes("user")
end

def gir_putts
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("gir_putt_ratio asc").includes("user")
end


end
