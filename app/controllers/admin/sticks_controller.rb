class Admin::SticksController < ApplicationController
  before_filter :require_super_admin
  layout "admin"
  skip_before_filter :require_no_super_admin
  
  def index
    puts "============================================"
    puts "============================================"
    @sticks = Stick.find(:all)
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @sticks }
#    end
  end
  
  def show
    @sticks = Stick.find(:all)
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @sticks }
#    end
  end
  
  def edit
    @stick = Stick.find(params[:id])
  end
  
  def new
    @stick = Stick.new
    #@stick.created_at = Time.now
    #respond_to do |format|
    #  format.html
    #  format.xml  { render :xml => @stick }
    #end
  end
  
	def sanitize_pairs
		PairHit.sanitize_self
		redirect_to(admin_sticks_path, :notice => 'Success!')
	end

  def  create
    puts "========================="
    @stick = Stick.new(params[:stick])
    #@stick.created_at = Time.now
    if @stick.save
      puts "saved"
      redirect_to(admin_sticks_path, :notice => 'Stick was successfully created.')
    else
      puts "unsaved"
      redirect_to(admin_sticks_path, :notice => 'Stick was NOT successfully created.')
    end
  end
  
  def update
    @stick = Stick.find(params[:id])
    if @stick.update_attributes(params[:stick])
      redirect_to(admin_sticks_path, :notice => 'Stick was successfully updated.')
    else
      redirect_to(admin_sticks_path, :notice => 'Stick was not successfully updated.')
    end
  end
  
  
  #  def index
  #    
  #    @countries = Country.find(:all)
  #    
  #    respond_to do |format|
  #      format.html # index.html.erb
  #      format.xml  { render :xml => @coutries }
  #    end
  #  end
  #  
  #  def new
  #    @country = Country.new
  #  end
  #  
  # 
  #  def create 
  #    @country = Country.new(params[:country])
  #    @country.save
  #    redirect_to(admin_countries_path, :notice => 'Golf club was successfully updated.')   
  #  end

end
