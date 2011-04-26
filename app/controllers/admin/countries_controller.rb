class Admin::CountriesController < ApplicationController
  before_filter :require_super_admin
  layout "admin"


  
  def index
    
    @countries = Country.find(:all)
    
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coutries }
    end
  end
  
 def new
   @country = Country.new
   
   
 end
  
 
 def create 
       @country = Country.new(params[:country])
      @country.save
      redirect_to(admin_countries_path, :notice => 'Golf club was successfully updated.')
   
   
 end
 end