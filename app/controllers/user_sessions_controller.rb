class UserSessionsController < ApplicationController
  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :require_no_user, :only => [:index]
  
 	
	def index
	    store_location
			@golf_club = GolfClub.new
			respond_to do |format|
				format.html
				format.xml  { render :xml => @golf_club }
			end      
		#end
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
      flash[:notice] = t "form.login_ok"
      redirect_back_or_default loged_in_path
    else
      redirect_to welcome_path
      flash[:notice] = t "form.login_fail"
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    #redirect_back_or_default welcome_url
	redirect_to welcome_url
  end
end
