class UserController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_owner, :only => [:update, :edit]
  skip_before_filter :header, :only => [:login_or_register, :new, :create]
  before_filter :require_user, :only => [:bag, :edit, :update]
  
  
  def bag
    @users_sticks = current_user.users_sticks
    @user = User.find(current_user) #current_user   
    @stick_attributes_name = "users_sticks_attributes[]"
    @new_stick_attributes_name = "new_stick_attributes_name[]" 
  
    store_location
  end

  
  def bag_update
      params[:user] = merge_hash(params[:user], "stick_attributes_name", "new_stick_attributes_name")
            
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to bag_user_path }
          format.xml  { head :ok }
        else
          format.html { render :action => "bag" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
    end  
  end                                      
                                           
                                           
  def login_or_register                    
  end                                      
                                           
   def new                                 
    @user = User.new                       
  end                                      
                                           
  def edit                                 
    @user = current_user                   
  end                                      
                                           
  def create                               
    @user = User.new(params[:user])        
      if @user.save                        
       redirect_back_or_default(welcome_path)
      else                                 
       render :action => "new"             
      end                                  
  end                                      
                                           
  def update                               
                                           
      @user = current_user                 
      if @user.update_attributes(params[:user])
        redirect_to welcome_path           
      else                                 
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
    end                                    
  end                                      
end                                        
                                           