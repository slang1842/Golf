class Admin::UsersController < ApplicationController
  before_filter :require_super_admin
  layout "admin"
  skip_before_filter :require_no_super_admin

  def index
    
    @users = User.where(:is_super_admin => false)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end
  

  def is_admin(user)
    if user.admin
      return true
    else
      return false
    end
  end

  def give_admin_rights
    logger.debug params[:id]
    @user = User.find(params[:id])
    
    if @user.admin
      User.update(params[:id], {:admin => '0'} )
    else
      User.update(params[:id], {:admin => '1'} )
    end
    redirect_to(admin_users_path, :notice => 'User updated.')
  end

  def edit
    logger.debug params[:id]
    @user = User.find(params[:id])    
    if @user.is_blocked
      User.update(params[:id], {:is_blocked =>'0'} )
    else
      User.update(params[:id], {:is_blocked=>'1'} )
    end    
    redirect_to(admin_users_path, :notice => 'User updated.')
  end
  

end






















