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
  
  def edit
    store_location
    @golf_club = GolfClub.find(current_user.golf_club.id)
		@link_id = "edit_info"
  end

  def edit_fields
    store_location
    @golf_club = GolfClub.find(current_user.golf_club.id)
		@link_id = "edit_fields"
    render '/fields/index'
  end
  
  def create
    @golf_club = GolfClub.new(params[:golf_club])
    @golf_club.user = current_user
    
   
    if @golf_club.save
      redirect_to loged_in_path
      flash[:notice] = "golf_club"
    else
      render :action => "new"       
    end
  end


  def show
    @club = GolfClub.find(:first, :conditions => {:id => current_user.golf_club.id})
    @users = User.find(:all, :conditions => {:golf_club_id => @club.id })
    render '/golf_club/show'
  end
  
  def update
    @golf_club = GolfClub.find(current_user.golf_club.id)
    if @golf_club.update_attributes(params[:golf_club])
      redirect_to(golf_club_path, :notice => 'Golf club was successfully updated.')
    else
      redirect_to(golf_club_path, :notice => 'Golf club was not successfully updated.')
      
    end
  end
  
  # /
  #   def destroy
  #     @golf_club = GolfClub.find(params[:id])
  #     @golf_club.destroy
  # 
  #     respond_to do |format|
  #       format.html { redirect_to(golf_clubs_url) }
  #       format.xml  { head :ok }
  #     end
  #   end
  #   /
  
  def update_banner
		@golf_club = GolfClub.find(params[:id])
		if @golf_club.update_attributes
		end
			redirect_to "/side_ad"
  end

  private
  def countries
    @contries = Country.all
    #@country = Country.find(current_user.country.id)
  end
 
end
