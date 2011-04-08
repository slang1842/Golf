class UsersSticksController < ApplicationController

  def destroy
    @users_stick = UsersStick.find(params[:id])
    @user_stick_id = @users_stick.id
    @users_stick.destroy
    
    respond_to do |format|
      format.js
      format.xml  { head :ok }
    end
  end
  
end
