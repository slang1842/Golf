class UserController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_owner, :only => [:update, :edit]
  skip_before_filter :header, :only => [:login_or_register, :new, :create]
  before_filter :require_user, :only => [:edit, :update, :bag, :update_bag]
 
  def login_or_register                    
  end                                      

  def new                                 
    @user = User.new 
    store_location
  end                                      

  def edit                                 
    @user = current_user                   
  end                                      

  def create
    @add_golf_club = false
    
    @params = params[:user]
    @add_club = @params[:add_club]
    @golf_club = @params[:golf_club]
    #====================================
    if  @add_club == true
      @add_club = false
      @add_golf_club = true
    else
      @add_club == false
    end
    #====================================
    @user = User.new(params[:user])        
    if @user.save                        
      if @add_golf_club == true
        redirect_to new_golf_club_path
      elsif @add_golf_club == false
        redirect_back_or_default(welcome_path)
      end      
    else                                 
      render :action => "new"             
    end                                  
  end                                      

  def update
    @add_golf_club = false
    
    @params = params[:user]
    @add_club = @params[:add_club]
    @golf_club = @params[:golf_club]
    #====================================
    if  @add_club
      @add_club = false
      @add_golf_club = true
    end
    #====================================
    unless @golf_club == current_user.golf_club
      current_user.update_attributes(:admin => false)
    end
    #====================================
    @user = current_user                 
    if @user.update_attributes(params[:user])
      if @add_golf_club
        redirect_to new_golf_club_path
      else
        redirect_to welcome_path
      end
                
    else      
      respond_to do |format|
        format.html { render :action => "edit" }
      end
    end                                    
  end   
  #============================================
  def bag
    # bag
    @user_sticks_id = :get_value
    
    @users_sticks = current_user.users_sticks
    @user = User.find(current_user)  
    @sticks_attributes = "users_sticks_attributes[]"
    @new_sticks_attributes = (@user.users_sticks.count > 0) ? "new_users_sticks_attributes[]" : @sticks_attributes

    #Balls
    @balls = current_user.balls
    @balls_attributes = "balls_attributes[]"
    @new_balls_attributes = (@balls.count > 0) ? "new_balls_attributes[]" : @balls_attributes
   
    store_location
  end 
  
  
  def update_bag
    @user = current_user
    @users_sticks = current_user.users_sticks
    @user = User.find(current_user)
    @sticks_attributes = "users_sticks_attributes[]"
    @new_sticks_attributes = (@user.users_sticks.count > 0) ? "new_users_sticks_attributes[]" : @sticks_attributes
    
    #Balls
    @balls = current_user.balls
    @balls_attributes = "balls_attributes[]"
    @new_balls_attributes = (@balls.count > 0) ? "new_balls_attributes[]" : @balls_attributes
    
    params[:user] = merge_hash(params[:user], "users_sticks_attributes", "new_users_sticks_attributes")
    params[:user] = merge_hash(params[:user], "balls_attributes", "new_balls_attributes")

      
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
end