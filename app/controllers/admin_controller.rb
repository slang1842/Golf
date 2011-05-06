class AdminController < ApplicationController
  before_filter :require_super_admin
  skip_before_filter :require_no_super_admin
  
   /
  def index
    
  end
  
  private
 
  def authenticate_http
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == USER_NAME && password == PASSWORD
    end
  end
  /
end