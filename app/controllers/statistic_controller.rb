class StatisticController < ApplicationController
  skip_before_filter :require_user
  respond_to :html, :js, :json

  def statistics
    redirect_to view_statistic_path if Statistic.check_golf_club_pay_banner_time_limit && 
      Statistic.main_statistics #&&
      #Statistic.all_sticks_statistics &&
      #Statistic.user_progres &&
      #Statistic.game_statistics_general 
			
  end
      
  def view
    @statistic = Statistic.find(:all)
    #@GameStatisticsByHoles = GameStatisticsByHoles.all
    #@GameStatisticsBySticks = GameStatisticsBySticks.all
  end

	
		
   
		def edit
			@user_params = User.find(params[:user_id])
			#@user_params_hints = @user_params.hints
			@is_admin = true if current_user.admin == true
 		   @is_coach = true if @user_params.coach == current_user.id
  	  @has_couch = true unless (@user_params.coach == false || @user_params.coach == nil)
  	  #@coach_hints = current_user.hints
  	  @current_club_trainer = User.find(@user_params.golf_club.user_id)

  	  @user_sticks = UsersStick.where(:user_id => @user_params.id).includes(:stick)
  	  @statistic = Statistic.where(:user_id => @user_params.id)
			@link_id = "by_clubs"
		end

		def render_single_stats
			@user_params = User.includes("statistics", "failed_strokes").find(params[:user_id])
			#@user_params_hint = @user_params.hints.where(:stick_id => params[:stick_id]).first || Hint.create({:user_id => params[:user_id], :stick_id => params[:stick_id]})
			@is_admin = true if current_user.admin == true
 		   @is_coach = true if @user_params.coach == current_user.id
  	  @has_couch = true unless (@user_params.coach == false || @user_params.coach == nil)
			#@coach_hint = current_user.hints.where(:stick_id => params[:stick_id]).first || Hint.create({:user_id => current_user.id, :stick_id => params[:stick_id]})
			@statistic = @user_params.statistics.where(:stick_id => params[:stick_id]).first
			@failed_strokes = @user_params.failed_strokes.where(:statistic_id => @statistic.id)
			@stick = Stick.find(params[:stick_id]) unless params[:stick_id].to_i == 999
			response['Cache-Control'] = 'no-store, no-cache, must-revalidate, post-check=0, pre-check=0'
			response['Pragma'] = 'no-cache'
			response['Expires'] = 'Sun, 19 Nov 1978 05:00:00 GMT'
			respond_to do |format|
				format.js { render :layout => false, :content_type => "text/javascript; charset=UTF-8" }
			end
			
		end
  
	def update
    Hint.update_attributes(params[:c_hint])
  end

  def update_hints
    conditions = {:user_id => params[:hint][:user_id], :stick_id => params[:hint][:stick_id]}
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

	def by_fields
		@user_params = User.find(params[:user_id])
		@user_params_fields_limited = SingleFieldStatistic.where(:user_id => params[:user_id]).order("updated_at desc").limit(100)
		@link_id = "by_fields"
	end
  
end



