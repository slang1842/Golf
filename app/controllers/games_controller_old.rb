class GamesController < ApplicationController
  before_filter :require_user

  
  def save
    @games = Game.where(:user_id => current_user.id)

    respond_to do |format|
      format.html
      format.js 
      format.xml  { render :xml => @games }
    end
  end
 
  def index
   
    @games = Game.where(:user_id => current_user.id)

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @games }
    end
  end
   def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  
  def new
    @user = current_user
    @game = Game.new
    @form_type = params[:form_type]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  
  def edit
    @user = current_user
    @game = Game.find(params[:id])
  end

  
  def create
    @game = Game.new(params[:game])
    @form_type = params[:form_type]
    respond_to do |format|
      if @game.save
        format.html { redirect_to(game_edit_path(@game.id, params[:commit]), :notice => 'Game was successfully created.') }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to(@game, :notice => 'Game was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
  

  
  def prev   
    hole_filter
    @count = params[:count]
    @game = Game.find(params[:id])
    @hit_type = params[:hit_type]
    @active_hole = params[:active]
    @active_hole = @active_hole.to_i - 1
    @form = params[:form_id]
    conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => 1, 
               :real_hit => @hit_type}
     
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
    #@hit = Hit.find_or_create_by_game_id_and_hole_number(@game.id, @active_hole)
    end
  
  
  def next    
    hole_filter
    @count = params[:count]
    @game = Game.find(params[:id])
    @hit_type = params[:hit_type]
    @active_hole = params[:active].to_i + 1
    @form = params[:form_id]
    conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => 1, 
               :real_hit => @hit_type}
     
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
    #@hit = Hit.find_or_create_by_game_id_and_hole_number(@game.id, @active_hole)
    end
    
    
    def game_index
    @hit = Hit.new
    @game = Game.find(params[:id])
    game_type = @game.game_type
    @holes = Hole.where(:field_id => @game.field_id)
    case game_type
      when 1
        hole_num = 1..9  
        @active_hole = 1
        @start_hole = 1
        @end_hole = 9
      when 2
        hole_num = 10..18 
        @active_hole = 10
        @start_hole = 10 
        @end_hole = 18
      when 3
        hole_num = 1..18
        @active_hole = 1
        @start_hole = 1
        @end_hole = 18   
      end
    @holes_filtered = @holes.where(:hole_number => hole_num)
    @form_type = params[:form_type]
   if @form_type == 'new'
     redirect_to plan_path(@game.id,@active_hole), :remote => :true
   else
 respond_to do |format|
      format.html 
    end
    end
  end
  def results
    hole_filter
    @count = params[:count].to_i
    @put = params[:puts].to_i
    @active_hole = params[:active]
    @game = Game.find(params[:id])
    @game_id = params[:id]
    b = @count - @put
    a = (1..b)
    a.each do |i|
     conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => i, 
               :real_hit => 'r'}
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
     end
     a = ((b+1)..@count)
     a.each do |i|
     conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => i, 
               :real_hit => 'r',
               :stick_type => 'PUTTER'}
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
     end
     @hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r',:hit_number => 1..@count)     
     @hit_type = 'r'
    respond_to do |format|
      format.js
      format.html
    end
  end
  def plan
    hole_filter
    @active_hole = params[:active]
    @game = Game.find(params[:id])
    conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => 1, 
               :real_hit => 'p'}
     
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
     @hit_type = 'p'
     
    respond_to do |format|
      format.js
      format.html  
    end
  end
  def details
    hole_filter
    @active_hole = params[:active]
    @game = Game.find(params[:id])
    @hit = Hit.new
    respond_to do |format|
      format.js
      format.html
    end
  end
  def hole_filter
     @game = Game.find(params[:id])
    game_type = @game.game_type
    @holes = Hole.where(:field_id => @game.field_id)
    case game_type
      when 1
        hole_num = 1..9  
        @start_hole = 1
        @end_hole = 9
      when 2
        hole_num = 10..18 
        @start_hole = 10 
        @end_hole = 18
      when 3
        hole_num = 1..18
        @start_hole = 1
        @end_hole = 18   
      end
    @holes_filtered = @holes.where(:hole_number => hole_num)
  end
 def result_render
   hole_filter
   @active_hole = params[:active]
   @game_id = params[:id]
   end
   
  def hit_next
    @hit_type = params[:hit_type].to_str
    @active_hole = params[:active_hole]
    @game_id = params[:id]
    @game = Game.find_by_id(@game_id)
    @form_id = params[:form_id].to_str
    @active_hit = params[:hit].to_i + 1
         conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => @active_hit, 
               :real_hit => @hit_type}
     
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
  end
  def hit_prev
    @hit_type = params[:hit_type]
    @active_hole = params[:active_hole]
    @game_id = params[:id].to_i
    @game = Game.find_by_id(@game_id)
    @form_id = params[:form_id].to_str
    @active_hit = params[:hit].to_i - 1
    if @active_hit < 1
      @active_hit = @active_hit + 1
    end
     conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => @active_hit, 
               :real_hit => @hit_type}
     
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
     end
   def preva
     hole_filter
     @game = Game.find(params[:id])
     @game_id = params[:id]
     @active_hole = params[:active]
     @active_hole = @active_hole.to_i - 1
     if @active_hole = 0
       @active_hole = 1
     end
   end
   def nexta
     hole_filter
     @game = Game.find(params[:id])
     @game_id = params[:id]
     @active_hole = params[:active].to_i + 1
    end
end