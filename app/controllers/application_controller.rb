class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  
  
    private
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

    

    def store_location
      session[:return_to] = request.request_uri
    end

    def require_user
      logger.debug "ApplicationController::require_user"
      unless current_user
        store_location
        #flash[:notice] = "You must be logged in to access this page"
        redirect_to welcome_path
        return false
      end
    end

    def require_no_user
      logger.debug "ApplicationController::require_no_user"
      if current_user
        store_location
        #flash[:notice] = "You must be logged out to access this page"
        redirect_to redirect_back_or_default #account_url
        return false
      end
    end
  
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def require_owner
      #if current_user
      puts "<============== Params id: #{params[:id]} == current user id #{current_user.id} ? ==================>"
      unless params[:id].to_i == current_user.id 
          redirect_to clubs_path
          return false
      end
      #end
    end
  
  
end
