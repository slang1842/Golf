class StandardStatisticController < ApplicationController
 before_filter :require_user
	
def index
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("gir_percentage desc")
	@link_id = "gir"
end

def gir
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("gir_percentage desc").includes("user")
	@link_id = "gir"
end

def putts
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("avg_putts desc").includes("user")
	@link_id = "puttering"
end

def stableford
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("sbf_avg_per_hole desc").includes("user")
	@link_id = "stableford"
end

def gir_putts
	@user_params = User.find(params[:user_id])
	@statistics = StandardStatistic.order("gir_putt_ratio asc").includes("user")
	@link_id = "girputts"
end


end
