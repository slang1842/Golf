class SideAdController < ApplicationController
	before_filter :require_admin

	def index
		@side_ads = SideAd.where(:golf_club_id => current_user.golf_club_id)
		respond_to :js
	end

	def new
		@side_ad = SideAd.new(:golf_club_id => current_user.golf_club_id)
		respond_to :js
	end

	def create
		@side_ad = SideAd.new(params[:side_ad])
		@side_ad.golf_club_id = current_user.golf_club_id
		@side_ad.save!
		redirect_to "/side_ad"
	end

	def update
		@side_ad = SideAd.find(params[:id])
		@side_ad.update_attributes(params[:side_ad])
		@side_ad.save!
		redirect_to "/side_ad"
	end

	def edit
		@side_ad = SideAd.find(params[:id])
		respond_to :js
	end

	def destroy
		@side_ad = SideAd.find(params[:id])
		@side_ad.destroy
		redirect_to "/side_ad"
	end


end
