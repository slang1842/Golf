class WelcomeController < ApplicationController

before_filter :require_user, :only => :index
before_filter :require_no_user, :only => :welcome
skip_before_filter :header
before_filter :require_no_super_admin, :only => :index

  def index
    store_location
    render( :layout => 'layouts/application' )
  end
	
	def welcome
    store_location
		render( :layout => 'layouts/welcome' )
	end
end
