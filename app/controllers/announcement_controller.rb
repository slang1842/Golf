class AnnouncementController < ApplicationController

	before_filter :require_user
	before_filter :require_announcement_owner, :only => [:edit, :destroy, :update]
	

	def new
		@announcement = Announcement.new(:user_id => current_user.id, :golf_club_id => current_user.golf_club_id)
		respond_to :js
	end

	def edit
		@announcement = Announcement.find(params[:id])
	end

	def update
		@announcement = Announcement.find(params[:id])
		@announcement.update_attributes(params[:announcement])
		@announcement.save!
		redirect_to welcome_path
	end

	def create
		@announcement = Announcement.new(params[:announcement])
		@announcement.user_id = current_user.id
		@announcement.golf_club_id = current_user.golf_club_id
		@announcement.save!
		redirect_to welcome_path
	end

	def destroy
		@announcement = Announcement.find(params[:id])
		@announcement.destroy
		redirect_to welcome_path
	end

	def require_announcement_owner
		@announcement = Announcement.find(params[:id])
		if current_user.id == @announcement.user_id || current_user.is_super_admin
			return true
		else
			return false
		end
	end

	def index_for_owner
		@announcements = Announcement.by_single_club(current_user.golf_club_id)
	end

	def load_more
		case session[:newsfeed_filter]
			when 'all'
				@announcements = Announcement.for_newsfeed(5, session[:announcement_offset], current_user.golf_club_id)
			when 'my_feed'
				@announcements = Announcement.my_feed(5, session[:announcement_offset], current_user.golf_club_id)
			when 'admin'
				@announcements = Announcement.by_admin(5, session[:announcement_offset])
			end
		session[:announcement_offset] += 5
		respond_to :js
	end

	def expand
		@announcement = Announcement.find(params[:id])
		respond_to :js
	end

	def filter
		session[:newsfeed_filter] = params[:filter_options]
		session[:announcement_offset] = 0
		case session[:newsfeed_filter]
			when 'all'
				@announcements = Announcement.for_newsfeed(5, session[:announcement_offset], current_user.golf_club_id)
			when 'my_feed'
				@announcements = Announcement.my_feed(5, session[:announcement_offset], current_user.golf_club_id)
			when 'admin'
				@announcements = Announcement.by_admin(5, session[:announcement_offset])
			end
		respond_to :js
	end

end
