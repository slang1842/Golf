class Admin::CountriesController < ApplicationController
  before_filter :require_super_admin
  layout "admin"
  skip_before_filter :require_no_super_admin
  
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
    redirect_to(admin_countries_path, :notice => 'Country was successfully updated.')   
  end
end