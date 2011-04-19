class GamesController < ApplicationController
  before_filter :require_user

  
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
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

    respond_to do |format|
      if @game.save
        format.html { redirect_to(game_index_path(@game.id), :notice => 'Game was successfully created.') }
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
    @active_hole = params[:active]
    @active_hole = @active_hole.to_i - 1
    @form = params[:form_id]
    @hit = Hit.where(:game_id => @game.id, :hole_number => @active_hole, :hit_number => 1)
     if defined?(@hit).nil? then 
       @hit = self.new( params[:game_id => @game.id, :hole_number => @active_hole, :hit_number => 1])
     end
    
    
    end
  
  
  def next    
    hole_filter
    @active_hole = params[:active].to_i + 1
    @form = params[:form_id]
    @hit = Hit.where(:game_id => @game.id, :hole_number => @active_hole, :hit_number => 1)
     if defined?(@hit).nil? then 
       @hit = self.new( params[:game_id => @game.id, :hole_number => @active_hole, :hit_number => 1])
     end
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
    
 respond_to do |format|
      format.html 
    end

  end
  def results
    hole_filter
    @active_hole = params[:active]
    @game = Game.find(params[:id])
    @hit = Hit.new
    respond_to do |format|
      format.js
      format.html
    end
  end
  def plan
    hole_filter
    @active_hole = params[:active]
    @game = Game.find(params[:id])
    @hit = Hit.new
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
 
  def hit_next
    @active_hole = params[:active_hole]
    @game = Game.where(:id => params[:game_id])
    @form_id = params[:form_id].to_str
    @active_hit = params[:hit].to_i + 1
    @hit = Hit.where(:game_id => @game.id, :hole_number => @active_hole, :hit_number => @active_hit)
     if defined?(@hit).nil? then 
       @hit = self.new( params[:game_id => @game.id, :hole_number => @active_hole, :hit_number => @active_hit])
     end
  end
  def hit_prev
    @active_hole = params[:active_hole]
    @game = Game.where(:id => params[:game_id])
    @form_id = params[:form_id].to_str
    @active_hit = params[:hit].to_i - 1
    if @active_hit < 1
      @active_hit = @active_hit + 1
    end
    @hit = Hit.where(:game_id => @game.id, :hole_number => @active_hole, :hit_number => @active_hit)
     if defined?(@hit).nil? then 
       @hit = self.new( params[:game_id => @game.id, :hole_number => @active_hole, :hit_number => @active_hit])
     end
  end
end