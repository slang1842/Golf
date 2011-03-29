class GolfClubsController < ApplicationController
  before_filter :require_user
  before_filter :check_club, :only => [:main, :index]
 #before_filter :is_club_admin_or_owner, :only => [:index, :edit]
  
  def new
    countries
    @golf_club = GolfClub.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @golf_club }
    end
  end
  
  def index
    countries
    @country = Country.find(current_user)
  end

  
	def show
	@golf_club = GolfClub.find(params[:id])
		unless @golf_club.check_club_status
			redirect_back_or_default clubs_path
		else		
		end
	end

  

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
  
    respond_to do |format|
      if @golf_club.update_attributes(params[:golf_club])
        format.html { redirect_to(@golf_club, :notice => 'Golf club was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @golf_club.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  def destroy
    @golf_club = GolfClub.find(params[:id])
    @golf_club.destroy

    respond_to do |format|
      format.html { redirect_to(golf_clubs_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def countries
    @contries = Country.all
    @country = Country.find(current_user)
  end
  
=begin
  def is_club_admin_or_owner
    unless is_owner(current_user) or is_admin(current_user) != false
    
    
    / ssssssssss /
    
    end
    #unless current_user && current_user.is_club_admin_or_owner
    #  redirect_to clubs_path
    #end
  end
=end

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
end






















