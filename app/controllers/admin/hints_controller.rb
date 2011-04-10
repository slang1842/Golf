class Admin::HintsController < ApplicationController
  layout "admin"


  
  def index
    
    @hints = Hint.find(:all)
    
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hints }
    end
  end
  
  
  
  
  def show
   @hint = Hint.find(params[:id])
    
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hint }
    end
  end

 def edit
   @hint = Hint.find(params[:id])
   
  end



  

  def destroy
  @hint = Hint.find(params[:id])
    @hint.destroy

    respond_to do |format|
      format.html { redirect_to(admin_hints_path) }
      format.xml  { head :ok }
    end
  end
 
  

  

end






















