class GolfClubController < ApplicationController

 before_filter :require_admin, :except => [:create, :new]
  before_filter :require_user, :only => [:create, :new]
  
  def new
    countries
    @golf_club = GolfClub.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @golf_club }
    end
  end
  /
  def show #index
    countries
  end
  /
 def edit
    store_location
    @golf_club = GolfClub.find(current_user)
  end

  
 def create
    @golf_club = GolfClub.new(params[:golf_club])
    @golf_club.user = current_user
    
    respond_to do |format|
      if @golf_club.save
        #current_user.admin = true
        #current_user.golf_club_id = @golf_club.id    
        format.html { redirect_to(loged_in_path, :notice => "Golf club #{@golf_club.name} was successfully created. Administrator will accept it.") }
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

end
