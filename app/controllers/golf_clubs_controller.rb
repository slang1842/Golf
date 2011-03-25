class GolfClubsController < ApplicationController
  before_filter :require_no_user => :new

  def login_or_register
    @golf_club = GolfClub.new
      respond_to do |format|
        format.html
        format.xml  { render :xml => @golf_club }
      end      
  end
  
  
  def new
    @golf_club = GolfClub.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @golf_club }
    end
  end
  
  
  def index
    @golf_clubs = GolfClub.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @golf_clubs }
    end
  end

  
  def show
    @golf_club = GolfClub.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @golf_club }
    end
  end
  

 def edit
    @golf_club = GolfClub.find(params[:id])
  end

  
 def create
    @golf_club = GolfClub.new(params[:golf_club])
   
    respond_to do |format|
      if @golf_club.save
        format.html { redirect_to(@golf_club, :notice => 'Golf club was successfully created.') }
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
end
