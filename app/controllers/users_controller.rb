class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_owner, :only => [:update, :edit]
  skip_before_filter :header, :only => [:login_or_register, :new, :create]
  
  def login_or_register
    
  
  end
 
   def new
    @user = User.new
      respond_to do |format|
      format.html
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to(user_profile_path)}
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
      @user = User.find(params[:id])
      respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(clubs_path, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
    

end
