class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  
  private
  
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def current_user_session
      logger.debug "ApplicationController::current_user_session"
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      logger.debug "ApplicationController::current_user"
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
     def require_user
      logger.debug "ApplicationController::require_user"
      unless current_user
        store_location
        flash.now[:notice] = "You must be logged in to access this page"
        redirect_to login_or_register_path
        return false
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
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def require_owner
      unless params[:id].to_i == current_user.id
          store_location
          redirect_to welcome_path
          return false
      end
    end
    
    
  
  
end
