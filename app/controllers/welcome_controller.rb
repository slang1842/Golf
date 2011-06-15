class WelcomeController < ApplicationController

  before_filter :require_user, :only => :index
  before_filter :require_no_user, :only => :welcome
  skip_before_filter :header
  before_filter :require_no_super_admin, :only => :index

  def index
    store_location
    @top_users_progress = StatisticUserProgres.find(:all, :order => 'user_progress', :limit => 5)    
    @max_hit = Hit.where("real_hit = 'p' OR real_hit = 'rp'").order('hit_distance').select("DISTINCT user_id").limit(5)
    render( :layout => 'layouts/application' )
  end
	
	def welcome
    store_location
		render( :layout => 'layouts/welcome' )
	end
end
