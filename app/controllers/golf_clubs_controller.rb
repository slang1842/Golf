class GolfClubsController < ApplicationController
  # GET /golf_clubs
  # GET /golf_clubs.xml
  def index
    @golf_clubs = GolfClub.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @golf_clubs }
    end
  end

  # GET /golf_clubs/1
  # GET /golf_clubs/1.xml
  def show
    @golf_club = GolfClub.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @golf_club }
    end
  end

  # GET /golf_clubs/new
  # GET /golf_clubs/new.xml
  def new
    @golf_club = GolfClub.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @golf_club }
    end
  end

  # GET /golf_clubs/1/edit
  def edit
    @golf_club = GolfClub.find(params[:id])
  end

  # POST /golf_clubs
  # POST /golf_clubs.xml
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

  # PUT /golf_clubs/1
  # PUT /golf_clubs/1.xml
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

  # DELETE /golf_clubs/1
  # DELETE /golf_clubs/1.xml
  def destroy
    @golf_club = GolfClub.find(params[:id])
    @golf_club.destroy

    respond_to do |format|
      format.html { redirect_to(golf_clubs_url) }
      format.xml  { head :ok }
    end
  end
end
