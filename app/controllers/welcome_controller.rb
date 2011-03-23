class WelcomeController < ApplicationController

before_filter :require_user, :only => :index
before_filter :require_no_user, :only => :welcome

  def index
	
    render( :layout => 'layouts/application' )
  end
	
	def welcome
		render( :layout => 'layouts/welcome' )
	end
end
