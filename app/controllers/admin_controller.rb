class AdminController < ApplicationController
  USER_NAME, PASSWORD = "admin", "golfmaster"

  before_filter :authenticate_http
  
  def index
    
  end
  
  private
  
  def authenticate_http
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == USER_NAME && password == PASSWORD
    end
  end
end