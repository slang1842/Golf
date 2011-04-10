class Admin::UsersController < ApplicationController
  layout "admin"


  
  def index
    
    @users = User.find(:all)
    
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end
  


  
  def update
    @user = User.find(params[:id])
    User.update (params[:id], {:accepted=>'1'} )
    redirect_to(admin_golf_club_path, :notice => 'Golf club was successfully updated.')
  end
  

end






















