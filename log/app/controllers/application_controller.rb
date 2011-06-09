class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  before_filter :is_blocked, :only => :current_user
  before_filter :require_no_super_admin
  before_filter :is_blocked
  
  private

  def self.do_i_have_main_statistic(user)
    return user.stick.count > 0 && Statistic.where(:user_id == user.id).count > 0
  end

  def is_blocked
    if current_user
      if current_user.is_blocked
        redirect_to logout_path
        return true
      else
        return false
      end
    end
  end
    
  def store_location
    session[:return_to] = request.fullpath
  end
    
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
    
  def require_user
    unless current_user
      store_location
      flash.now[:notice] = "You must be logged in to access this page"
      redirect_to login_or_register_path
      return false
    end
  end
    
  def require_super_admin
    if current_user
      unless current_user.is_super_admin
        redirect_to welcome_path
      end
    else
      redirect_to welcome_url
    end
  end
    
  def require_no_super_admin
    if current_user
      if current_user.is_super_admin
        current_user_session.destroy
        redirect_to welcome_url
      end
    end
  end
    
    
  def require_admin
    if require_user
      unless current_user.admin
        flash.now[:notice] = "You have no access this page"
        redirect_to welcome_path
      end
    end
  end
    
  def require_no_user
    logger.debug "ApplicationController::require_no_user"
    if current_user
      store_location
      flash.now[:notice] = "You must be logged out to access this page"
      redirect_to loged_in_path
      return false
    end
  end

  def redirect_back
    redirect_to(session[:return_to])
    session[:return_to] = nil
  end
    
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
    
  / def require_owner
      unless params[:id].to_i == current_user.id
          store_location
          redirect_to welcome_path
          return false
      end
    end/
    
    
  def merge_hash params, attributes_name, new_attributes_name
    if params && params.include?(new_attributes_name)
      params[attributes_name] = {} unless params[attributes_name]
      max = params[attributes_name].keys.max.to_i
      params[new_attributes_name].each do |new_attributes|
        max = max + 1
        params[attributes_name][max] = new_attributes
      end
      params.delete(new_attributes_name)
    end
    return params
  end
      
  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

end
