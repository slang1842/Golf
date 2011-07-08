class HitsController < ApplicationController
  before_filter :require_user
  # GET /hits
  # GET /hits.xml
  def index
    @hits = Hit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hits }
    end
  end

  # GET /hits/1
  # GET /hits/1.xml
  def show
    @hit = Hit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hit }
    end
  end

  # GET /hits/new
  # GET /hits/new.xml
  def new
    @hit = Hit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hit }
    end
  end

  # GET /hits/1/edit
  def edit
    @hit = Hit.find(params[:id])
  end

  # POST /hits
  # POST /hits.xml
  def create
    @hit = Hit.new(params[:hit])

    respond_to do |format|
      if @hit.save
        format.html { redirect_to(@hit, :notice => 'Hit was successfully created.') }
        format.xml  { render :xml => @hit, :status => :created, :location => @hit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hits/1
  # PUT /hits/1.xml
  def update
    @hit = Hit.find(params[:id])
    convert_to_m(@hit)
    @hit.update_attributes(params[:hit])
  end
  
  def hit_update
  @hit = Hit.find(params[:id])
    convert_to_m(@hit)
    respond_to do |format|
      if @hit.update_attributes(params[:hit])
        format.html { redirect_to(@hit, :notice => 'Hit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hit.errors, :status => :unprocessable_entity }
      end
    end
  end
  # DELETE /hits/1
  # DELETE /hits/1.xml
  def destroy
    @hit = Hit.find(params[:id])
    @hit.destroy

    respond_to do |format|
      format.html { redirect_to(hits_url) }
      format.xml  { head :ok }
    end
  end
  
 def convert_to_feet(hit)
    if current_user.measurement == 'foots' && hit.hit_distance != nil
      @a = hit.hit_distance
      @b = hit.distance_to_hole
      hit.hit_distance = @a.to_i / 0.3048
      hit.distance_to_hole = @b.to_i / 0.3048
      hit.update_attributes(params [:hit])
    end
  end
  def convert_to_m(hit)
      if current_user.measurement == 'foots' && hit.hit_distance != nil
      @a = hit.hit_distance
      @b = hit.distance_to_hole
      hit.hit_distance = @a.to_i * 0.3048
      hit.distance_to_hole = @b.to_i * 0.3048
      hit.update_attributes(params [:hit])
    end
  end
end
