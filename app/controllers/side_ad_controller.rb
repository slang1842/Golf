class SideAdController < ApplicationController
	before_filter :require_admin

	def index
		@side_ads = SideAd.where(:golf_club_id => current_user.golf_club_id)
		@link_id = "manage_ads"
	end

	def new
		@side_ad = SideAd.new(:golf_club_id => current_user.golf_club_id)
		@link_id = "manage_ads"
	end

	def create
		@side_ad = SideAd.new(params[:side_ad])
		@side_ad.golf_club_id = current_user.golf_club_id
		@side_ad.save!
		@link_id = "manage_ads"
		redirect_to "/side_ad"
	end

	def update
		@side_ad = SideAd.find(params[:id])
		@side_ad.update_attributes(params[:side_ad])
		@side_ad.save!
		@link_id = "manage_ads"
		redirect_to "/side_ad"
	end

	def edit
		@side_ad = SideAd.find(params[:id])
		@link_id = "manage_ads"
	end

	def destroy
		@side_ad = SideAd.find(params[:id])
		@side_ad.destroy
		@link_id = "manage_ads"
		redirect_to "/side_ad"
	end


end
