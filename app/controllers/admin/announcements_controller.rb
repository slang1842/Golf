class Admin::AnnouncementsController < ApplicationController
	before_filter :require_super_admin
	layout "admin"
  skip_before_filter :require_no_super_admin

	def index
		@announcements = Announcement.all
	end
	
	def destroy
		@announcement = Announcement.find(params[:id])
		@announcement.destroy
		redirect_to admin_announcements_path
	end

	def create
		@announcement = Announcement.new(params[:announcement])
		@announcement.user_id = current_user.id
		@announcement.golf_club_id = 999
		@announcement.save!
		redirect_to admin_announcements_path
	end

	def new
		@announcement = Announcement.new	
	end

	def edit
		@announcement = Announcement.find(params[:id])
	end
	
	def update
		@announcement = Announcement.find(params[:id])
		@announcement.update_attributes(params[:announcement])
		@announcement.save!
		redirect_to admin_announcements_path
	end

end
