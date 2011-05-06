class AdminController < ApplicationController
  before_filter :require_super_admin, :except => :index
  skip_before_filter :require_no_super_admin
  skip_before_filter :require_user, :only => :index
  before_filter :require_user, :only => :index
    
  def index
    
  end
  

end