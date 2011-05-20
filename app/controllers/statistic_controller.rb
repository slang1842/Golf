class StatisticController < ApplicationController

 
  def statistics
    if Statistic.calculate_statistics
      redirect_to view_statistic_path
    else
    end
  end
  
  def game_statistics
    redirect_to view_statistic_path if Statistic.calculate_statistics && Statistic.game_statistics
  end
    
  def view
    @statistic = Statistic.find(:all)
  end
  
  def show
    
    
    @viewer = current_user
    #@user = User.find(params[:id])
   
    if @viewer.admin
      # skatitajs ir treneris
      @trainee = @viewer
      @user = User.find(params[:id])
      #@user_sticks = UsersStick.where(:user_id => @user.id)
      @user_sticks = @user.sticks.find(:all)
      @istrainee = 1
      
    else
      # skatitajs ir lietotajs
      @user = @viewer
      @istrainee = 0
      # ka meklet treneri
      @trainee = @user
    end
    @user_sticks = Stick.where(user_id = @user.id)
    @golf_club = GolfClub.find(@user.golf_club_id)
    @results = Statistic.where(:user_id => @user.id).order("stick_id ASC")
  end
end
