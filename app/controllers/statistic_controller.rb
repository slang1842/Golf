class StatisticController < ApplicationController
  skip_before_filter :require_user
  respond_to :json, :html

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
    @is_admin = true if current_user.admin == true
    @is_admin_and_coach = true if current_user.admin == true && @user_params.coach == current_user.id
    @current_club_trainer = User.find(@user_params.golf_club.user_id)
    @current_hints = Hint.where(:user_id => @current_club_trainer.id)

    # ======== mini stats menu
    @GameStatisticsByHoles = GameStatisticsByHoles.where(:user_id => params[:user_id]) #.order("field_id ASC")
    @hit_asc = Hit.where(:user_id => params[:user_id]).order("stick_id ASC")
    @hit_dsc = Hit.where(:user_id => params[:user_id]).order("stick_id DSC")

    @gir = @GameStatisticsByHoles.sum(:gir_sum)
    @puts = @GameStatisticsByHoles.sum(:put_sum)
    @strokes = @GameStatisticsByHoles.sum(:hit_sum)
      
    #@hits = @hit_asc.hits_r.limit(3)
    @top_good = Stick.where(:stick_id => @hit_asc.stick_id).stick_type.limit(3)
    @top_fail = Stick.where(:stick_id => @hit_dsc.stick.id).stick_type.limit(3)
      
    # ======== mini stats menu
      
    store_location

    unless @is_admin
      if @user_params.id != current_user.id
        render_404
      end


    

    end
      
    @user_sticks = UsersStick.where(:user_id => @user_params.id).order("@user_params.stick_type ASC")
    @statistic = Statistic.where(:user_id => @user_params.id)
  
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

  def get_statistic_by_field
   
   
    @result = [@gir, @puts, @strokes] #, @hits, @top_good, @top_fail]
    
    respond_with @result
  end
  
end



