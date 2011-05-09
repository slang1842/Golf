class UserStatsController < ApplicationController
   before_filter :require_user


def show
  @viewer = current_user
   #@user = User.find(params[:id])
   
  if @viewer.admin=1
    # skatitajs ir treneris
      @trainee = @viewer
      @user = User.find(params[:id])
      @istrainee = 1
  else
    # skatitajs ir lietotajs
      @user = @viewer
      @istrainee = 0
      # ka meklet treneri
      @trainee = @user
  end
      
      @golf_club = GolfClub.find(@user.golf_club_id)
      @results = Statistic.where(:user_id => @user.id).order("stick_id ASC")
      @sticks = Stick.find(:all,:order=> 'id')

  
end


def populate
  @statistic_row = Statistic.new
  @statistic_row.user_id = 1
  @statistic_row.stick_id = 2
  @statistic_row.place_teebox = rand(100)
  @statistic_row.place_feairway = rand(100)
  @statistic_row.place_next_fairway = rand(100)
  @statistic_row.place_semi_raf = rand(100)
  @statistic_row.place_raf = rand(100)
  @statistic_row.place_for_green = rand(100)
  @statistic_row.place_green = rand(100)
  @statistic_row.place_fairway_sand = rand(100)
  @statistic_row.place_green_sand = rand(100)
  @statistic_row.place_wood = rand(100)
  @statistic_row.place_from_water = rand(100)
  @statistic_row.stance_normal = rand(100)
  @statistic_row.stance_right_leg_lower = rand(100)
  @statistic_row.stance_left_leg_lower = rand(100)
  @statistic_row.stance_ball_lower = rand(100)
  @statistic_row.stance_ball_higher = rand(100)
  @statistic_row.direction_straigth = rand(100)
  @statistic_row.direction_fade = rand(100)
  @statistic_row.direction_drow = rand(100)
  @statistic_row.direction_slice = rand(100)
  @statistic_row.direction_hook = rand(100)
  @statistic_row.temperature_cold = rand(100)
  @statistic_row.temperature_normal = rand(100)
  @statistic_row.temperature_hot = rand(100)
  @statistic_row.weather_normal = rand(100)
  @statistic_row.weather_wind = rand(100)
  @statistic_row.weather_rain = rand(100)
  @statistic_row.weather_wind_and_rain = rand(100)
  @statistic_row.trajectory_normal = rand(100)
  @statistic_row.trajectory_high = rand(100)
  @statistic_row.trajectory_low = rand(100)
  @statistic_row.wind_from_behind = rand(100)
  @statistic_row.wind_from_front = rand(100)
  @statistic_row.wind_from_left = rand(100)
  @statistic_row.wind_from_right = rand(100)
  @statistic_row.save
  redirect_to :action => "show"
end

def sendmail
    email = @params["email"]
    recipient = email["recipient"]
    subject = email["subject"]
    message = email["message"]
    Emailer.deliver_send_hint(recipient, subject, message)
    return if request.xhr?
    render :text => 'Message sent successfully'
  end
  
end
