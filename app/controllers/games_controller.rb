class GamesController < ApplicationController
 
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
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

 
  def edit
    @game = Game.find(params[:id])
  end

   def create
      
    @game = Game.new(params[:game])
    @game.save
    @path = '/game_' + params[:commit].to_s + '/' + @game.id.to_s + '/1'
     redirect_to @path
  end

 
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

 
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
   # GET /games/new
  # GET /games/new.xml
  def game_holes
    @active_hole = params[:active_hole].to_i
    @game = Game.find(params[:game_id])
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
    @form_type = params[:form_type]
   
  end
  def hole_switch
    game_holes
    @form_id = params[:form_id].to_s
    if @direction == 'next' && @active_hole != @end_hole
      @active_hole = @active_hole + 1
    elsif  @direction == 'prev' && @active_hole != @start_hole
      @active_hole = @active_hole - 1
    end
      
  end
  def hit_switch
    game_holes
    @direction = params[:direction].to_s
    @form_id = params[:form_id].to_s
    @active_hit = params[:active_hit].to_i
    if @direction == 'next'
      @active_hit = @active_hit + 1
    elsif  @direction == 'prev' && @active_hit != 1
      @active_hit = @active_hit - 1
    end
    
    end
    def plan
    game_holes    
    @active_hole = params[:active_hole]
    conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => 1, 
               :real_hit => 'p'}
     
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
     @hit_type = 'p'
     @form_id = 'plan'
      respond_to do |format|
        format.js
        render '/games/hit_edit'
      end
    end
    
    def res
      game_holes    
      @active_hole = params[:active_hole]
      render '/games/res_menu', :locals => {:game_id => params[:game_id], :active_hole => 1}
    end
    
    def results
      game_holes
      @active_hole = params[:active_hole]
      conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => 1, 
               :real_hit => 'r'}
     
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
     @hit_type = 'r'
      respond_to do |format|
        format.js
        render '/games/hit_edit'
      end
    end
    def details
      game_holes
      @active_hole = params[:active_hole]
   
    conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => 1, 
               :real_hit => 'r'}
     
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
     @hit_type = 'r'
      respond_to do |format|
        format.js
        render '/games/hit_edit'
      end
    end
end
