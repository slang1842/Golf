class GamesController < ApplicationController
 before_filter :require_user
 before_filter :require_game_owner, :except => [ :index,  :new, :create]
 
    def index
    @games = Game.where(:user_id => current_user.id)

    respond_to do |format|
      format.js
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
    
    @path = '/game_' + params[:form_id].to_s + '/' + @game.id.to_s + '/1' + '/1' + '/new'
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
  
  
  def hole_switch
    game_holes
    @direction = params[:direction].to_s
    @active_hole = params[:active_hole].to_i
    @form_id = params[:form_id].to_s
    @form_id = params[:form_id].to_s
    
    @path = '/game_' + @form_id.to_s + '/' + @game.id.to_s + '/' + @active_hole.to_s + '/1/0/0'
    #redirect_to @path, :remote => :true
    

  end
  
  def hit_switch
    game_holes
    @active_hole = params[:active_hole]
    @direction = params[:direction].to_s
    @form_id = params[:form_id].to_s
    @active_hit = params[:active_hit].to_i
    if @direction == 'next'
      @active_hit = @active_hit + 1
    elsif  @direction == 'prev' && @active_hit != 1
      @active_hit = @active_hit - 1
    end
    
    @path = '/game_' + @form_id.to_s + '/' + @game.id.to_s + '/' + @active_hole.to_s + '/' + @active_hit.to_s
    #redirect_to @path, :remote => :true
   end
    
   def plan
    game_holes
      @active_hit = params[:active_hit].to_i
      if @active_hit == 0
        @active_hit = 1
      end
      @active_hole = params[:active_hole].to_i
      if @active_hole < @start_hole
        @active_hole = @start_hole
      end
      conditions = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => @active_hit, 
               :real_hit => 'p',
               :user_id => current_user.id}
     
     @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
     convert_to_feet(@hit)
     @form_id = 'plan'
     if params[:hits] == 'new'
         render '/games/hit_edit'
       end
  puts @game.id
    end
    
    def res
      game_holes    
      @active_hole = params[:active_hole]
      render '/games/res_menu', :locals => {:game_id => params[:game_id], :active_hole => @active_hole}
    end
    
    def results
      @form_id = 'results'
      game_holes
      @active_hit = params[:active_hit].to_i
      @active_hole = params[:active_hole].to_i
      @hitcount = params[:hits].to_i
       if @active_hit == 0
        @active_hit = 1
      end
      if @hitcount == nil
        @hitcount = 0
      end
      @puts = params[:puts].to_i
       @form_id = 'results'
      if @active_hole < @start_hole
        @active_hole = @start_hole
      end
      
      if @hitcount != 0
           @hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r')
           @hits.each   do |f|
            f.destroy
            end
           b = @hitcount - @puts
            a = (1..b)
                 a.each do |i|
                conditions = { :game_id => @game.id, 
                              :hole_number => @active_hole,
                              :hit_number => i, 
                              :real_hit => 'r'}
            @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
            convert_to_feet(@hit)
            end
            
          a = ((b+1)..@hitcount)
          a.each do |i|
              conditions = { :game_id => @game.id, 
                             :hole_number => @active_hole,
                             :hit_number => i, 
                             :real_hit => 'r',
                             :stick_type => 'PUTTER'}
              @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
                          convert_to_feet(@hit)
              end

       @hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r') 
       
    else
      @hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r')
    end
    if params[:hits] == 'new'
         render '/games/hit_edit_results'
       end
     #comments(@hit, 'results')
    end
    
    
    
    
    def details
      game_holes
      @active_hole = params[:active_hole]
      @active_hit = params[:active_hit]
      if @active_hit.to_i == 0
        @active_hit = 1
      end
      
              conditions2 = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => @active_hit, 
               :real_hit => 'pp',
               :user_id => current_user.id}
               conditions1 = { :game_id => @game.id, 
               :hole_number => @active_hole,
               :hit_number => @active_hit, 
               :real_hit => 'rp',
               :user_id => current_user.id
               }
      if @active_hit.to_i != 1
        fix_params(@active_hole, @active_hit, @game.id)
       else
          @hit_r_final = Hit.find(:first, :conditions => conditions1) || Hit.create(conditions1)
        @hit_p_final = Hit.find(:first, :conditions => conditions2) || Hit.create(conditions2)
       
        end
     convert_to_feet(@hit_r_final)
               convert_to_feet(@hit_p_final)
               conditions3 = { :hit_planed_id => @hit_p_final.id,
                               :hit_real_id => @hit_r_final.id,
                               :users_id => current_user.id}
     @pair_hit = PairHit.find(:first, :conditions => conditions3) || PairHit.create(conditions3)
     @hit_r_final.pair_id = @pair_hit.id
     @hit_p_final.pair_id = @pair_hit.id
     @hit_r_final.update_attributes(params[:pair_id])
     @hit_p_final.update_attributes(params[:pair_id])
     @pair_hit.update_attributes(params[:pair_hit])
     @form_id = 'details'
       if params[:hits] == 'new'
         render '/games/hit_edit_details'
       # else
       #   respond_to do |format|
       #     format.js
       #   end
       end
       
      # comments(@hit_real, 'details')
    end
    
    
    def results_starter
      @hitcount = params[:hits].to_i
      @puts = params[:puts].to_i
      if @hitcount > 0 
       
              @path = '/game_results' + '/' + params[:game_id].to_s + '/' + params[:active_hole].to_s + '/results/' + @hitcount.to_s + '/'+ @puts.to_s
              #@path = '/game_results' + '/' + params[:game_id].to_s + '/' + params[:active_hole].to_s + '/results/0/0'
              redirect_to @path, :remote => :true
      
      #@path = '/game_results' + '/' + params[:game_id].to_s + '/' + params[:active_hole].to_s + '/results/' + @hits.to_s + '/'+ @puts.to_s
      end   
    #redirect_to @path, :remote => :true
    end
    
    
    
     def convert_to_feet(hit)
    if current_user.measurement == 'foots' && hit.hit_distance != nil
      @a = hit.hit_distance
      @b = hit.distance_to_hole
      hit.hit_distance = @a.to_i / 0.3048
      hit.distance_to_hole = @b.to_i / 0.3048
      hit.update_attributes(params [:hit])
    end
  end
  def convert_to_m(hit)
      if current_user.measurement == 'foots' && hit.hit_distance != nil 
      @a = hit.hit_distance
      @b = hit.distance_to_hole
      hit.hit_distance = @a.to_i * 0.3048
      hit.distance_to_hole = @b.to_i * 0.3048
      hit.update_attributes(params [:hit])
    end
  end
  def fix_params(active_hole, active_hit, game_id)
                conditions6 = { :game_id => game_id, 
               :hole_number => active_hole,
               :hit_number => active_hit.to_i - 1, 
               :real_hit => 'rp',
               :user_id => current_user.id}
               conditions5 = {:game_id => game_id, 
               :hole_number => active_hole,
               :hit_number => active_hit.to_i - 1, 
               :real_hit => 'pp',
               :user_id => current_user.id
                 }
               conditions2 = { :game_id => game_id, 
               :hole_number => active_hole,
               :hit_number => active_hit, 
               :real_hit => 'pp',
               :user_id => current_user.id}
               conditions1 = { :game_id => game_id, 
               :hole_number => active_hole,
               :hit_number => active_hit, 
               :real_hit => 'rp',
               :user_id => current_user.id
               }
               
              
       @hit_real_prev = Hit.find(:first, :conditions => conditions6)
       @hit_planned_prev = Hit.find(:first, :conditions => conditions5)
               
       
               @hit_real = Hit.find(:first, :conditions => conditions1) || Hit.create(conditions1)
               @hit_planned = Hit.find(:first, :conditions => conditions2) || Hit.create(conditions2)
               place_from = @hit_real_prev.land_place
               wind = @hit_planned_prev.wind
               @hit_real.update_attributes({:place_from => place_from, :wind => wind})
               @hit_planned.update_attributes({:place_from => place_from, :wind => wind})
               @hit_r_final = @hit_real
               @hit_p_final = @hit_planned
               
  end
  def comments(hit, type, hole_hit)
    game_holes
    
  end
  def hit_update
     game_holes
     require_game_owner
     @game.update_attributes(params[:game])
     @game.update_attributes(params[:hit])
     @game_id = @game.id
     @active_hit = params[:next_hit]
     @active_hit1 = params[:active_hit]
    if @active_hit == 'next'
      @active_hit = @active_hit1.to_i + 1
    end
    if @active_hit == 0
      @active_hit = 1
    end
    if @active_hit == 'prev'
      @active_hit = @active_hit1.to_i - 1
    end
    @game_id = params[:id]
    @path = '/game_' + params[:form_id].to_s + '/' + @game.id.to_s + '/' + params[:next_hole].to_s + '/' + @active_hit.to_s + '/'
    redirect_to @path, :remote => :true
  end
 
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
    conditions7 = {:field_id => @game.field_id, :hole_number => @active_hole}
  @hole = Hole.find(:first, :conditions => conditions7)
   end
  
   def require_game_owner
       game_holes
      if  @game.user_id == current_user.id
        return true
      else 
        return false
      end
    end
end
