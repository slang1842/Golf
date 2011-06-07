class StatisticController < ApplicationController
  skip_before_filter :require_user
  respond_to :json, :html, :js

  def statistics
    redirect_to view_statistic_path if Statistic.check_golf_club_pay_banner_time_limit && 
      Statistic.main_statistics &&
      Statistic.all_sticks_statistics &&
      Statistic.game_statistics_by_sticks &&
      Statistic.game_statistics_by_holes &&
      Statistic.user_progres &&
      Statistic.game_filter_statistic &&
      Statistic.game_statistics_general
  end
      
  def view
    @statistic = Statistic.find(:all)
    @GameStatisticsByHoles = GameStatisticsByHoles.all
    @GameStatisticsBySticks = GameStatisticsBySticks.all
  end

  def edit
    @user_params = User.find(params[:user_id])
    @is_admin = true if current_user.admin == true
    @is_admin_and_coach = true if current_user.admin == true && @user_params.coach == current_user.id
    @current_club_trainer = User.find(@user_params.golf_club.user_id)
    @current_hints = Hint.where(:user_id => @current_club_trainer.id)

    @user_sticks = UsersStick.where(:user_id => @user_params.id).order("@user_params.stick_type ASC")
    @statistic = Statistic.where(:user_id => @user_params.id)


    # ======== mini stats menu
    @GameStatisticsByHoles = GameStatisticsByHoles.where(:user_id => params[:user_id]) #.order("field_id ASC")
    
    @gir = @GameStatisticsByHoles.sum(:gir_sum)
    @puts = @GameStatisticsByHoles.sum(:put_sum)
    @strokes = @GameStatisticsByHoles.sum(:hit_sum)

    @top_good = AllStickStatistic.where(:user_id => params[:user_id]).order('stick_progres DESC').limit(3)
    @top_fail = AllStickStatistic.where(:user_id => params[:user_id]).order('stick_progres').limit(3)
    @top_sticks = GameStatisticsBySticks.where(:user_id => params[:user_id]).order('hits_r').limit(3) 
    # ======== mini stats menu
      
    store_location

    unless @is_admin
      if @user_params.id != current_user.id
        render_404
      end


    

    end
      
  
  end

  def update
    Hint.update_attributes(params[:c_hint])
  end

  def update_hints
    #conditions = {:user_id => current_user.id, :stick_id => params[:stick_id]}
    #@hint = Hint.find(:first, :conditions => conditions)
    #@hint.update_attributes(params[:hint])
    #redirect_back


    conditions = {:user_id => current_user.id, :stick_id => params[:hint][:stick_id]}
    @hint = Hint.find(:first, :conditions => conditions) || Hint.new(conditions)
    @hint.update_attributes(params[:hint])
    redirect_back
  end

  def filter_statistic
    @place_from = params[:place_from]
    @direction = params[:direction]
    @stance = params[:stance]
    @temperature = params[:temperature]
    @trajectory = params[:trajectory]
    @weather = params[:weather]
    @wind = params[:wind]
    @field = params[:field_id]
    @user_id = params[:user_id]

 
    @games_to_return = GameFilterStatistic.where(:user_id => @user_id).order("created_at DESC").limit(8)

    case @place_from.to_i
    when 1
      @games_to_return = @games_to_return.where(:place_green => true)
    when 2
      @games_to_return = @games_to_return.where(:place_teebox => true)
    when 3
      @games_to_return = @games_to_return.where(:place_feairway => true)
    when 4
      @games_to_return = @games_to_return.where(:place_next_fairway => true)
    when 5
      @games_to_return = @games_to_return.where(:place_semi_raf => true)
    when 6
      @games_to_return = @games_to_return.where(:place_raf => true)
    when 7
      @games_to_return = @games_to_return.where(:place_for_green => true)
    when 8
      @games_to_return = @games_to_return.where(:place_fairway_sand => true)
    when 9
      @games_to_return = @games_to_return.where(:place_green_sand => true)
    when 10
      @games_to_return = @games_to_return.where(:place_wood => true)
    when 11
      @games_to_return = @games_to_return.where(:place_from_water => true)      
    end

    case @stance.to_i
    when 1
      @games_to_return = @games_to_return.where(:stance_normal => true)
    when 2
      @games_to_return = @games_to_return.where(:stance_right_leg_lower => true)
    when 3
      @games_to_return = @games_to_return.where(:stance_left_leg_lower => true)
    when 4
      @games_to_return = @games_to_return.where(:stance_ball_lower => true)
    when 5
      @games_to_return = @games_to_return.where(:stance_ball_higher => true)
    end

    case @trajectory.to_i
    when 1
      @games_to_return = @games_to_return.where(:direction_straigth => true)
    when 2
      @games_to_return = @games_to_return.where(:direction_fade => true)
    when 3
      @games_to_return = @games_to_return.where(:direction_drow => true)
    when 4
      @games_to_return = @games_to_return.where(:direction_slice => true)
    when 5
      @games_to_return = @games_to_return.where(:direction_hook => true)
    end

    case @temperature.to_i
    when 1
      @games_to_return = @games_to_return.where(:temperature_hot => true)
    when 2
      @games_to_return = @games_to_return.where(:temperature_normal => true)
    when 3
      @games_to_return = @games_to_return.where(:temperature_cold => true)
    end

    case @weather.to_i
    when 1
      @games_to_return = @games_to_return.where(:weather_normal => true)
    when 2
      @games_to_return = @games_to_return.where(:weather_wind => true)
    when 3
      @games_to_return = @games_to_return.where(:weather_rain => true)
    when 4
      @games_to_return = @games_to_return.where(:weather_wind_and_rain => true)
    end

    case @trajectory.to_i
    when 1
      @games_to_return = @games_to_return.where(:trajectory_normal => true)
    when 2
      @games_to_return = @games_to_return.where(:trajectory_high => true)
    when 3
      @games_to_return = @games_to_return.where(:trajectory_low => true)
    end

    case @wind.to_i
    when 1
      @games_to_return = @games_to_return.where(:wind_from_behind => true)
    when 2
      @games_to_return = @games_to_return.where(:wind_from_front => true)
    when 3
      @games_to_return = @games_to_return.where(:wind_from_left => true)
    when 4
      @games_to_return = @games_to_return.where(:wind_from_right => true)
    end
  
    @filtered_games = @games_to_return
  end

  def user_place_in_golf_club
    @hcp = params[:hcp]
    @field_id = params[:field_id]
    @user_id = params[:user_id]


    @all_stats = StatisticUserProgres.where(:field_id => @field_id, :hcp => @hcp).order("user_progress DESC")
    @my_stats = @all_stats.where(:user_id => @user_id)

    #@three_better = @all_stats.where(:user_progress.to_i > @my_stats.user_progress.to_i).order("user_progress DESC").limit(3)
    #@three_worse = @all_stats.where(:user_progress.to_i < @my_stats.user_progress.to_i).order("user_progress DESC").limit(3)
  end
  
end



