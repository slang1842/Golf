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
			fetch_announcements
			fetch_side_ads
			render( :layout => 'layouts/application' )
    end
	end

	def welcome
    store_location
    render( :layout => 'layouts/welcome' )
  end

	private

		def fetch_announcements
				session[:announcement_offset] = 0
				i = 0 
				@announcements.each do |ann| 
					i += 1
				end
				session[:announcement_offset] += i
				session[:newsfeed_filter] = "all"
		end

		def fetch_side_ads
			@side_ads = SideAd.where(:golf_club_id => current_user.golf_club_id, :to_be_shown => true).limit(3).order("created_at desc")
		end

end
