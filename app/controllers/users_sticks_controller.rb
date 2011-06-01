class UsersSticksController < ApplicationController
  respond_to :json
  
  def destroy
    @users_stick = UsersStick.find(params[:id])
    @user_stick_id = @users_stick.id
    @users_stick.destroy
    
    respond_to do |format|
      format.js
      format.xml  { head :ok }
    end
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
