class UsersController < ApplicationController
   
  
  #before_filter :require_user, :only => 
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_owner, :only => [:update, :edit]
  
  
    
  
   
  #def show
  #  @user = User.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.xml  { render :xml => @user }
  #  end
  #end

   def new
    @user = User.new
      respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    #@country = Countrie
    #@golfclubs = GolfClub
    
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to(welcome_path, :notice => "ss") } #t "notices.user_created") }
        #format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        #format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
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
