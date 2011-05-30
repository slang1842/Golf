class StatisticController < ApplicationController
  skip_before_filter :require_user
 
  def statistics
    redirect_to view_statistic_path if Statistic.check_golf_club_pay_banner_time_limit && Statistic.main_statistics && Statistic.all_sticks_statistics && Statistic.game_statistics_by_sticks && Statistic.game_statistics_by_holes
  end
      
  def view
    @statistic = Statistic.find(:all)
    @GameStatisticsByHoles = GameStatisticsByHoles.all
    @GameStatisticsBySticks = GameStatisticsBySticks.all
  end

  def edit
    @user = User.find(params[:user_id])
    @is_admin = true if @user.admin == true

    
    @user_fields = Field.where(:golf_club_id => @user.golf_club.id)

    
    redirect_to main_statistic_path(:user_id => current_user.id, :field_id => Field.find(current_user.golf_club.id)) unless @is_admin == false && @user.id != current_user.id
    #sataisit redirect
    #pielikt klat field kontroli ne adminiem
      
    @field = Field.find(@user.golf_club.id)
    @user_sticks = UsersStick.where(:user_id => @user.id).order("stick.stick_type ASC")
    @statistic = Statistic.where(:user_id => @user.id, :stick_id => @user_sticks.id).order("stick.stick_type ASC")
   
    
  


    

  end

  def update

  end

end
