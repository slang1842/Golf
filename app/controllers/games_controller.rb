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

    respond_to do |format|
      if @game.save
        format.html { render '/games/hit_edit', :locals => {:game => @game, :active_hole => 1, :active_hit => 1, :form_id => params[:commit]} }        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
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
end
