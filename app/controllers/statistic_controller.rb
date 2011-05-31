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
    @user_params = User.find(params[:user_id])
    @is_admin = true if current_user.admin

    unless @is_admin
      if @user_params.id != current_user.id
        render_404
      end
    end
      
    @user_sticks = UsersStick.where(:user_id => @user_params.id).order("stick.stick_type ASC")
    @statistic = Statistic.where(:user_id => @user_params.id, :stick_id => @user_sticks.id).order("stick.stick_type ASC")
  
  end

  def update

  end

end
