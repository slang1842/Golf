class HintsController < ApplicationController
  # GET /hints
  # GET /hints.xml
  def index
    @hints = Hint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hints }
    end
  end

  # GET /hints/1
  # GET /hints/1.xml
  def show
    @hint = Hint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hint }
    end
  end

  # GET /hints/new
  # GET /hints/new.xml
  def new
    @hint = Hint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hint }
    end
  end

  # GET /hints/1/edit
  def edit
    @hint = Hint.find(params[:id])
  end

  # POST /hints
  # POST /hints.xml
  def create
    @hint = Hint.new(params[:hint])

    respond_to do |format|
      if @hint.save
        format.html { redirect_to(@hint, :notice => 'Hint was successfully created.') }
        format.xml  { render :xml => @hint, :status => :created, :location => @hint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hints/1
  # PUT /hints/1.xml
  def update
    @hint = Hint.find(params[:id])

    respond_to do |format|
      if @hint.update_attributes(params[:hint])
        format.html { redirect_to(@hint, :notice => 'Hint was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hints/1
  # DELETE /hints/1.xml
  def destroy
    @hint = Hint.find(params[:id])
    @hint.destroy

    respond_to do |format|
      format.html { redirect_to(hints_url) }
      format.xml  { head :ok }
    end
  end
end
