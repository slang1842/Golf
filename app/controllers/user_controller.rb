class UserController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_owner, :only => [:update, :edit]
  skip_before_filter :header, :only => [:login_or_register, :new, :create]
  before_filter :require_user, :only => [:bag, :edit, :update]
  
  
  def bag
    @user_sticks = current_user.users_sticks
    @user = current_user
    
     
     
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
