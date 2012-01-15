class WelcomeController < ApplicationController

  before_filter :require_no_user, :only => [:welcome]
  skip_before_filter :header
  before_filter :require_no_super_admin, :only => :welcome

  def index
    if current_user.is_super_admin
      redirect_to admin_path
    else
      store_location
		
      @top_users_progress = StatisticUserProgres.find(:all, :order => 'user_progress', :limit => 5)
      @max_hit = Hit.where("real_hit = 'p' OR real_hit = 'rp'").order('hit_distance').select("DISTINCT user_id").limit(5)
			@announcements = Announcement.latest(5, current_user.golf_club_id)
			session[:announcement_offset] = 0
			session[:announcement_offset] += 5
			render( :layout => 'layouts/application' )
    end
	end

	def welcome
    store_location
    render( :layout => 'layouts/welcome' )
  end

end
