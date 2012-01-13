class StatisticController < ApplicationController
  skip_before_filter :require_user
  respond_to :json, :html, :js

  def statistics
    #redirect_to view_statistic_path if Statistic.game_statistics_by_holes

    #/
    redirect_to view_statistic_path if Statistic.check_golf_club_pay_banner_time_limit && 
      Statistic.main_statistics &&
      Statistic.all_sticks_statistics &&
      Statistic.game_statistics_by_sticks &&
      Statistic.game_statistics_by_holes &&
      Statistic.user_progres &&
      Statistic.game_statistics_general
    #/
  end
      
  def view
    @statistic = Statistic.find(:all)
    @GameStatisticsByHoles = GameStatisticsByHoles.all
    @GameStatisticsBySticks = GameStatisticsBySticks.all
  end

  def edit
    @user_params = User.find(params[:user_id])
    
    @is_admin = true if current_user.admin == true
    @is_coach = true if @user_params.coach == current_user.id
    @has_couch = true unless (@user_params.coach == false || @user_params.coach == nil)
    
    @current_club_trainer = User.find(@user_params.golf_club.user_id)
    @current_hints = Hint.where(:user_id => @current_club_trainer.id)
    @user_params_games_limited = Game.where(:user_id => @user_params.id).limit(100)

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
    conditions = {:user_id => current_user.id, :stick_id => params[:hint][:stick_id]}
    @hint = Hint.find(:first, :conditions => conditions) || Hint.new(conditions)
    @hint.update_attributes(params[:hint])
    redirect_back
  end

  def filter_statistic
    if params[:place_from] != "" then place_from = params[:place_from] else place_from = (0..20) end
    if params[:stance] != "" then stance = params[:stance] else stance = (0..20) end
    if params[:temperature] != "" then temperature = params[:temperature] else temperature = (0..4) end
    if params[:trajectory] != "" then trajectory = params[:trajectory] else trajectory = (0..20) end
		if params[:trajectory_on_green] != "" && trajectory == (0..20) then trajectory = params[:trajectory_on_green] else trajectory = (0..20) end
    if params[:weather] != "" then weather = params[:weather] else weather = (0..20) end
    if params[:field_id] != "" then field_id = params[:field_id] else field_id = (0..20) end
		@result = Statistic.game_filter_statistic(params[:user_id], place_from, stance, temperature, trajectory, field_id, weather)


   # @all_filter_game_progress_arr = []
    
    #@filtered_games.each do |filtered_game|
     # @GSG = GameStatisticGeneral.where(:game_id => filtered_game.game_id).first
     # @all_filter_game_progress_arr.push(@GSG.game_progress)
    #end
    #@is_there_something_to_return = true
    
   # if @all_filter_game_progress_arr.size == 0
   #   @is_there_something_to_return = false
   # else
   #   @all_filter_game_progress = (@all_filter_game_progress_arr.sum / @all_filter_game_progress_arr.size)
   # end
    
  end

  def user_place_in_golf_club
    @hcp = params[:hcp]
    @field_id = params[:field_id]
    @user_id = params[:user_id]
    @is_something_to_return = true

    @user_stats = StatisticUserProgres.where(:field_id => @field_id, :hcp => @hcp).first
    @stats_arr = []
    @stats_arr.push([@user_stats.num - 3, @user_stats.num - 2,@user_stats.num - 1,@user_stats.num, @user_stats.num + 1, @user_stats.num + 2, @user_stats.num + 3]) if @user_stats
    @stats_arr.push(@user_stats.num) if @user_stats
    #@stats_arr = [@user_stats.num - 3, @user_stats.num - 2,@user_stats.num - 1,@user_stats.num, @user_stats.num + 1, @user_stats.num + 2, @user_stats.num + 3]

    if @stats_arr.size == 0
      @is_something_to_return = false
    else
      @stats_to_return = StatisticUserProgres.where('num IN  (?)', @stats_arr).order("num ASC") #DESC")

    end
    
   
  end
  
end



