class UsersSticksController < ApplicationController
  respond_to :json, :js
  
  def destroy
    @users_stick = UsersStick.find(params[:id])
    @user_stick_id = @users_stick.id
    @users_stick.destroy
    respond_to :js

  end
  
  def show
     @sticks = Sticks.find(params[:id])
     Respond_with @sticks  
  end

/
  def update
     @statistic = GolfClub.new(params[:statistic])
     
  end
  /
end
