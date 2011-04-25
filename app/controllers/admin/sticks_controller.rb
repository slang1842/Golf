class Admin::SticksController < ApplicationController
  before_filter :require_super_admin
  layout "admin"
  
  def index
    @sticks = Stick.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sticks }
    end
  end
  
  def show
    @sticks = Stick.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sticks }
    end
  end
  
  def edit
    @stick = Stick.find(params[:id])
  end
  
  def new
    @stick = Stick.new
    @stick.created_at = Time.now
    respond_to do |format|
      format.html
      format.xml  { render :xml => @stick }
    end
  end
  
  def  create
    @stick = Stick.new(params[:stick])
    @stick.created_at = Time.now
    respond_to do |format|
      if @stick.save
        format.html { redirect_back_or_default(admin_sticks_path) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stick.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @stick = Stick.find(params[:id])
    if @stick.update_attributes(params[:stick])
      redirect_to(admin_sticks_path, :notice => 'Golf club was successfully updated.')
    else
      redirect_to(admin_sticks_path, :notice => 'Golf club was not successfully updated.')
    end
  end

end
