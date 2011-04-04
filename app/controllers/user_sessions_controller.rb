class UserSessionsController < ApplicationController
  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :require_no_user, :only => [:index]
  
 	
	def index
    @golf_club = GolfClub.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @golf_club }
    end
	end
	
  def new
    @user_session = UserSession.new
  end
  
  
  def form
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_back_or_default(welcome_path)
      flash[:notice] = t "form.login_ok"
    else
      redirect_back_or_default(welcome_path)
      flash[:notice] = t "form.login_fail"
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to welcome_url
    #redirect_to welcome_url
  end
end
