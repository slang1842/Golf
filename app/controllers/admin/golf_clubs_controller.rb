class Admin::GolfClubsController < ApplicationController
  before_filter :require_super_admin
  layout "admin"
  skip_before_filter :require_no_super_admin
  
  def index
    
    @clubs = GolfClub.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @clubs }
    end
  end
  
  def edit
    @golf_club = GolfClub.find(params[:id])
  end


  
  def update
    @golf_club = GolfClub.find(params[:id])
    @golf_club.update_attributes(:accepted => params[:status])
    @user = User.find(@golf_club.user_id)
    
    @user.update_attributes(:admin => 1, :golf_club_id => @golf_club.id) if params[:status] == "yes"
    
    if @golf_club.update_attributes(params[:golf_club])
      redirect_to(admin_golf_clubs_path, :notice => 'Golf club was successfully updated.')
    else
      redirect_to(admin_golf_clubs_path, :notice => 'Golf club was not successfully updated.')
    end
  
  end 
  
  private
  def golfClubs
    @golfClubs = GolfClub.all
    #@country = Country.find(current_user.country.id)
  end
  
  private
  def countries
    @contries = Country.all
    #@country = Country.find(current_user.country.id)
  end
  

  


  
=begin

def is_club_admin_or_owner(club)
if ((admin or golf_club.id == club.id) || id == club.user_id)
return true
end
end


def check_club
unless current_user.golf_club == nil
unless current_user.golf_club.accepted == false or golf_club.user_id == current_user
#accepted
redirect_to loged_in_path
else
#unaccepted
flash.now[:notice] = "Your club has not been accepted"
end
else
#no club
redirect_to loged_in_path
end

end
=end
end