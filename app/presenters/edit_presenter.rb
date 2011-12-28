class Statistic::EditPresenter

	def initialize(user_id)
		@user = User.find(user_id)
		@user_id = @user_id
    
    @is_admin = true if current_user.admin == true
    @is_coach = true if @user.coach == current_user.id
    @has_couch = true unless (@user.coach == false || @user.coach == nil)
    
    @current_club_trainer = User.find(@user.golf_club.user_id)
    @current_hints = Hint.where(:user_id => @current_club_trainer.id)
    @user_params_games_limited = Game.where(:user_id => @user_id).limit(100)

    @user_sticks = UsersStick.where(:user_id => @user_id).order("@user_params.stick_type ASC")
    @statistic = Statistic.where(:user_id => @user_id)

    @GameStatisticsByHoles = GameStatisticsByHoles.where(:user_id => @user_id) #.order("field_id ASC")
    
    @gir = @GameStatisticsByHoles.sum(:gir_sum)
    @puts = @GameStatisticsByHoles.sum(:put_sum)
    @strokes = @GameStatisticsByHoles.sum(:hit_sum)

    @top_good = AllStickStatistic.where(:user_id => @user_id).order('stick_progres DESC').limit(3)
    @top_fail = AllStickStatistic.where(:user_id => @user_id).order('stick_progres').limit(3)
    @top_sticks = GameStatisticsBySticks.where(:user_id => @user_id).order('hits_r').limit(3) 
	end    

end
