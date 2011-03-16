class UserSessionsController < ApplicationController
  #before_filter :require_no_user => [:new, :create]
  #before_filter :require_user => :destroy

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
      redirect_back_or_default clubs_url
    else
      redirect_to welcome_path
      flash[:notice] = t "form.login_fail"
    end
  end

  def destroy
    current_user_session.destroy
    #flash[:notice] = "Logout successful!"
    redirect_back_or_default welcome_url
  end
end
