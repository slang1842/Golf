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
			@announcements = Announcement.for_newsfeed(5, 0, GolfClub.club_id_array_by_country(current_user.country_id))
			fetch_announcements
			fetch_side_ads
			render( :layout => 'layouts/application' )
    end
	end

	def welcome
		fetch_texts
		
		@announcements = Announcement.by_admin(4,0)
		@users = User.latest
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

		def fetch_texts
			@more_text = ""
			@header_text = ""
			@icon_1_text = ""
			@icon_2_text = ""
			@icon_3_text = ""
			@text = File.open("more_text.txt", "r") do |f|
				while (line = f.gets)
					@more_text += line
				end
			end
			@text = File.open("header_text.txt", "r") do |f|
				while (line = f.gets)
					@header_text += line
				end
			end
			@text = File.open("icon_1_text.txt", "r") do |f|
				while (line = f.gets)
					@icon_1_text += line
				end
			end
			@text = File.open("icon_2_text.txt", "r") do |f|
				while (line = f.gets)
					@icon_2_text += line
				end
			end
			@text = File.open("icon_3_text.txt", "r") do |f|
				while (line = f.gets)
					@icon_3_text += line
				end
			end
		end

end
