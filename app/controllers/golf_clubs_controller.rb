class GolfClubsController < ApplicationController
  before_filter :require_admin, :except => [:create, :new]
  before_filter :require_no_user, :only => [:create, :new]
  
  def new
    countries
    @golf_club = GolfClub.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @golf_club }
    end
  end
  
  def show #index
    countries
    #@country = Country.find(current_user)
  end
  
	#def show
	#@golf_club = GolfClub.find(params[:id])
	#	unless @golf_club.check_club_status
	#		redirect_back_or_default clubs_path
	#	else		
	#	end
	#end

 def edit
    @golf_club = GolfClub.find(current_user)
  end

  
 def create
    @golf_club = GolfClub.new(params[:golf_club])
    @golf_club.user = current_user
    
    respond_to do |format|
      if @golf_club.save
        format.html { redirect_to(clubs_path, :notice => "Golf club #{@golf_club.name} was successfully created.") }
        format.xml  { render :xml => @golf_club, :status => :created, :location => @golf_club }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @golf_club.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  def update
    @golf_club = GolfClub.find(params[:id])
      if @golf_club.update_attributes(params[:golf_club])
        redirect_to(clubs_path, :notice => 'Golf club was successfully updated.')
      else
        redirect_to(clubs_path, :notice => 'Golf club was not successfully updated.')
      
      end
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






















