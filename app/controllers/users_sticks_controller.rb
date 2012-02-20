class UsersSticksController < ApplicationController
  respond_to :json, :js
  
  def destroy
    @users_stick = UsersStick.find(params[:id])
    @user_stick_id = @users_stick.id
    @users_stick.destroy
    respond_to :js

  end

	def create
		@users_stick = UsersStick.new({:user_id => params[:user_id], :distance => 0, :shaft => 0, :degrees => 0, :shaft_strength => 0})
		UsersStick.skip_callbacks = true
		@users_stick.save
		UsersStick.skip_callbacks = false
		respond_to :js
	end
  
  def show
     @sticks = Sticks.find(params[:id])
     respond_with @sticks  
  end

/
  def update
     @statistic = GolfClub.new(params[:statistic])
     
  end
  /
end
