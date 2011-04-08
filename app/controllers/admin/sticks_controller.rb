class Admin::SticksController < ApplicationController
  
  layout "admin"
  
  def index
    
    @sticks = Stick.find(:all)
    
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sticks }
    end
  end
  
  
  def edit
  
   
 end
 
 def new
      
       @stick = Stick.new
       respond_to do |format|
      format.html
      format.xml  { render :xml => @stick }
    end
  end
  
  
end
