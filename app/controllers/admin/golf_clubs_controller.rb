class Admin::GolfClubsController < ApplicationController
  layout "admin"


  
  def index
    
    @clubs = GolfClub.find(:all, :conditions => "accepted = '0'")
    
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end
  
  
  
  
	def show
	 @clubs = GolfClub.find(:all, :conditions => "accepted = '0'")
    
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
	end

 def edit
   countries
    @golf_club = GolfClub.find(params[:id])
    @country = Country.find(@golf_club.countries_id)
   
  end

  


  
  def update
    @golf_club = GolfClub.find(params[:id])
    GolfClub.update (params[:id], {:accepted=>'1'} )
    redirect_to(admin_golf_clubs_path, :notice => 'Golf club was successfully updated.')
  end
  
/
  def destroy
    @golf_club = GolfClub.find(params[:id])
    @golf_club.destroy

    respond_to do |format|
      format.html { redirect_to(golf_clubs_url) }
      format.xml  { head :ok }
    end
  end
  /
  
  
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






















