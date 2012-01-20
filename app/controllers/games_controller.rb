class GamesController < ApplicationController
 before_filter :require_user
 before_filter :require_game_owner, :except => [ :index,  :new, :create, :more_games, :switch_hit_places]
 
    
 def index
 	@games = Game.find(
            :all,
            :conditions => {:user_id => current_user.id},
            :order =>  'created_at desc',
            :limit => 5
            )
  respond_to do |format|
      format.js
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
 end
  
	def get_stats
	 	@game_holes   
	  @field = Field.find(:first, :conditions => {:id => @game.field_id})
	  render '/game_statistics/view/'
	end
  
	def more_games  
    @count = params[:count].to_i + 5
    @games = Game.find(
            :all,
            :conditions => {:user_id => current_user.id},
            :order =>  'created_at desc',
            :limit => @count
            )
	end

  def show
    @game = Game.find(params[:id])
    store_location
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
               :hit_number => 1, 
               :real_hit => 'p',
               :user_id => current_user.id}
 	 	@hit = Hit.where(:game_id => @game.id,:hole_number => @active_hole, :real_hit => 'p', :user_id => current_user.id) 
		unless @hit.any?
			@hit = []
			@hit = @hit << Hit.create(conditions)
		end     
    @form_id = 'plan'
		convert_from_m(@hit[0])
    if params[:hits] == 'new'
    	render '/games/hit_edit'
    else
    	render 'games/plan'
    end
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
    @puts = params[:puts].to_i
    if @hitcount == nil || @hitcount == 0
    	@hitcount = 5
      @puts = 2
    end
      
    @form_id = 'results'
    if @active_hole < @start_hole
    	@active_hole = @start_hole
    end
    if @hitcount != 0
       @hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r')
       @hits.each do |f|
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
       end
       a = ((b+1)..@hitcount)
       a.each do |i|
      	 conditions = { :game_id => @game.id, 
                             :hole_number => @active_hole,
                             :hit_number => i, 
                             :real_hit => 'r',
                             :stick_id => 1 }
         @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
       end

       @hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r')     
    else
      @hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r')
    end

		@hits.each do |hit|
     convert_from_m(hit)
		end

    if params[:hits] == 'new'
         render '/games/hit_edit_results'  
    end
  end
    
	def details
  	game_holes
		fetch_hole_colors
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
    conditions3 = { :hit_planed_id => @hit_p_final.id,
                               :hit_real_id => @hit_r_final.id,
                               :user_id => current_user.id,
                               :game_id => @game.id}
     @pair_hit = PairHit.find(:first, :conditions => conditions3) || PairHit.create(conditions3)
     @hit_r_final.pair_id = @pair_hit.id
     @hit_p_final.pair_id = @pair_hit.id
		if @active_hit.to_i == 1
			update_hole_colors(@active_hole, @game.id)
			@hit_r_final.update_attributes(:place_from => 2)
			@hit_p_final.update_attributes(:place_from => 2)
			@hit_p_final.update_attributes(:distance_to_hole => @hole.get_proper_distance(@game.id))
		end
    @hit_r_final.update_attributes(params[:pair_id])
    @hit_p_final.update_attributes(params[:pair_id])
    @pair_hit.update_attributes(params[:pair_hit])
		convert_from_m(@hit_r_final)
		convert_from_m(@hit_p_final)
    @form_id = 'details'
		create_hit_colors(@game.id, @active_hole)
		puts @hits
    if params[:hits] == 'new'
    	render '/games/hit_edit_details'
    end
	end
       
	def results_starter
  	@hitcount = params[:hits].to_i
    @puts = params[:puts].to_i
    if @hitcount > 0 
    	get_results_with_count(params[:game_id].to_s,params[:active_hole].to_s, @hitcount, @puts)
    end   
  end
       

  def fix_params(active_hole, active_hit, game_id, hole_distance)
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
		if @hit_real_prev.hit_distance != nil && @hit_planned_prev.distance_to_hole != nil
			distance_to_hole = (@hit_planned_prev.distance_to_hole - @hit_real_prev.hit_distance).abs  
		else 
			distance_to_hole = 0
	  end
   	@hit_planned.update_attributes({:place_from => place_from, :distance_to_hole => distance_to_hole})
    @hit_r_final = @hit_real
    @hit_p_final = @hit_planned
	end
 
  def hit_update
		@next_hole = params[:next_hole].to_s
    require_game_owner
    if @game.update_attributes(params[:game])
    end
		#ugly fix
		i = 0
		while params[:game][:hits_attributes][:"#{i}"] != nil
			puts params[:game][:hits_attributes][:"#{i}"]
			@hit1 = Hit.find_by_id(params[:game][:hits_attributes][:"#{i}"][:id])
			convert_to_m(@hit1) if @hit1
			i += 1
		end
		#end of ugly fix	
	 if params[:form_id].to_s == "details" then update_hit_colors(@game.id, @hit1.hole_number, @hit1.hit_number) end
   @game_id = params[:game_id]
   @active_hit = params[:next_hit].to_s
   @active_hit1 = params[:active_hit]
     if @active_hit == 'next'
				@active_hit = @active_hit1.to_i + 1
     elsif @active_hit == '0'
      	@active_hit = 1
     elsif @active_hit == 'prev'
     	  @active_hit = @active_hit1.to_i - 1
     elsif @active_hit == 'save'   
     		@active_hit = @active_hit1
		 else
				@active_hit = params[:next_hit].to_s 
     end
     if params[:form_id].to_s == 'plan'
     		get_plan(params[:form_id], @game_id, @next_hole, @active_hit)
     elsif params[:form_id].to_s == 'results'
     	  get_results(params[:form_id], @game_id, @next_hole, @active_hit)
     elsif params[:form_id].to_s == 'details'
        get_details(params[:form_id], @game_id, @next_hole, @active_hit)
		 elsif params[:form_id].to_s == 'add_hit'
				add_planned_hit(@game_id, @next_hole, @active_hit)
		 elsif params[:form_id].to_s == 'remove_hit'
				remove_hit(@game_id, @next_hole)		
     end
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

	def fetch_hole_colors
		session[:hole_statuses] = {}
		@holes.each do |hole|
			statushole = StatusHole.find_or_create_by_game_id_and_hole_number({:game_id => @game.id, :hole_number => hole.hole_number})
			
			session[:hole_statuses][:"#{hole.hole_number}"] = statushole.completeness
		end
	end
  
	def update_hole_colors(hole_num, game_id)
		@hole_status = StatusHole.find_or_create_by_hole_number_and_game_id({:hole_number => hole_num, :game_id => game_id})
		if @hole_status.completeness == nil
			@hole_status.completeness = 1
			@hole_status.save!
			session[:hole_statuses][:"#{hole_num}"] = 1
		end
	end


	def check_hole_status(game_id, hole_number)
		status = true
		@planned_hits = Hit.where(:game_id => game_id, :hole_number => hole_number, :real_hit => "pp")
		@planned_hits.each do |planned|
			pair = PairHit.find_by_hit_planed_id(planned.id)
			real = Hit.find_by_id(pair.hit_real_id)
			if check_hits(real, planned) then status = true else status = false end				
		end	
		if status == true
			statushole = StatusHole.find_or_create_by_game_id_and_hole_number({:game_id => game_id, :hole_number => hole_number})
			statushole.completeness = 2
			statushole.save!
			session[:hole_statuses][:"#{hole_number}"] = 2
		end
	end	

	def create_hit_colors(game_id, hole_number)
		session[:hit_statuses] = {}
		session[:stick_names] = {}
		@hits = Hit.where(:game_id => game_id, :hole_number => hole_number, :real_hit => "pp")
			@hits.each do |planned|
			pair = PairHit.find_by_hit_planed_id(planned.id)
			real = Hit.find_by_id(pair.hit_real_id)
			check_and_update_color(real, planned)
		end				
	end


	def update_hit_colors(game_id, hole_number, hit_number)
		planned = Hit.where(:game_id => game_id, :hole_number => hole_number, :real_hit => "pp", :hit_number => hit_number).last
		real = Hit.where(:game_id => game_id, :hole_number => hole_number, :real_hit => "rp", :hit_number => hit_number).last
		check_and_update_color(real, planned)
	end


	def check_and_update_color(real, planned)
		if session.present?
			if check_hits(real, planned) == true
				session[:hit_statuses][:"#{planned.hit_number}"] = 1
			else
				session[:hit_statuses][:"#{planned.hit_number}"] = nil
			end
			if planned.stick_id != nil
				stick = Stick.find(planned.stick_id)
				session[:stick_names][:"#{planned.hit_number}"] = stick.short_name
			else
				session[:stick_names][:"#{planned.hit_number}"] = nil
				puts session[:hit_statuses][:"#{planned.hit_number}"]
			end
		end
	end


	def check_hits(real, planned)
			if planned.place_from != nil && planned.land_place != nil && planned.stance != nil && planned.trajectory != nil && planned.hit_distance != nil && real.land_place != nil && real.luck_factor != nil && real.hit_distance != nil && real.misdirection != nil && real.mistake != nil && planned.stick_id != nil
				return true
			else
				return false
		end
	end


  def require_game_owner
  	game_holes
    if  @game.user_id == current_user.id
      return true
    else 
      return false
    end
  end
   
  def print_game_plan
    game_holes
    render 'games/print_game_plan', :layout => 'print'
  end
    

	def switch_hit_places
		@places = Field.get_hit_place_colors(params[:id])
		puts @places
	end

private
	def remove_hit(game_id, hole_number)
		@hit = Hit.where(:game_id => game_id, :hole_number => hole_number).last
		if @hit.destroy	
			get_plan('plan', game_id, hole_number, 1)
		end
	end	

	def add_planned_hit(game_id, hole_number, hit_number)
		require_game_owner
		#end of ugly fix	
		@hit_last = Hit.where(:game_id => game_id, :hole_number => hole_number).last
		@hit = Hit.create!(:game_id => game_id, :hit_number => @hit_last.hit_number.to_i + 1, :hole_number => hole_number, :real_hit => 'p', :user_id => current_user.id )
		get_plan('plan', game_id, hole_number, 1)
	end	

  def get_plan(form_id, game_id, next_hole, active_hit)
  	@form_id = form_id
    @game_id = game_id
    @next_hole = next_hole
    @active_hit = active_hit
    get_game_holes(game_id, next_hole)
    if @active_hit == 0
  	  @active_hit = 1
    end
    if @active_hole.to_i < @start_hole
  	  @active_hole = @start_hole
    end
    conditions = { :game_id => @game_id, 
               :hole_number => @active_hole,
               :hit_number => @active_hit, 
               :real_hit => 'p',
               :user_id => current_user.id}
		@hit = Hit.where(:game_id => @game.id,:hole_number => @active_hole, :real_hit => 'p', :user_id => current_user.id) 
		if @hit.any?
		else
			@hit = []
			@hit = @hit << Hit.create(conditions)
		end
		@hit.each {|h| convert_from_m(h)}     
    @form_id = 'plan'
    render 'games/plan'
	end
    
	def get_results(form_id, game_id, next_hole, active_hit)
	  @form_id = form_id
    @game_id = game_id
    @next_hole = next_hole
    @active_hit = active_hit
    get_game_holes(@game_id, @next_hole)
    @form_id = 'results'     
    @active_hole = next_hole
    if active_hit == 0
	    @active_hit = 1
      end
      if @active_hole.to_i < @start_hole
        @active_hole = @start_hole
      end
			@putts = Hit.where(:game_id => game_id,:hole_number => @active_hole, :real_hit => 'r', :stick_id => 1)
      @hits = Hit.where(:game_id => game_id,:hole_number => @active_hole, :real_hit => 'r')  
      if @hits.any?
				@hitcount = @hits.length 
				@puts = @putts.length
	      render 'results'
      else
	      @hitcount = 5
        @puts = 2
        b = @hitcount - @puts
        a = (1..b)
        a.each do |i|
	        conditions = { :game_id => @game_id, 
                              :hole_number => @next_hole,
                              :hit_number => i, 
                              :real_hit => 'r'}
	        @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
            #convert_to_feet(@hit)
        	end
            
        a = ((b+1)..@hitcount)
        a.each do |i|
					conditions = { :game_id => @game_id, 
                             :hole_number => @next_hole,
                             :hit_number => i, 
                             :real_hit => 'r',
                             :stick_id => 1 }
              @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
                          #convert_to_feet(@hit)
           end
     	@hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r') 
			@hits.each {|h| convert_from_m(h)}
      render 'results'     
  	end
	end
     
	def get_details(form_id, game_id, next_hole, active_hit)
	  @form_id = form_id
    @game_id = game_id
    @next_hole = next_hole
    @active_hit = active_hit
	  get_game_holes(@game_id, @next_hole)
    conditions2 = { :game_id => @game_id, 
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
   	fix_params(@active_hole, @active_hit, @game_id, @hole.distance)
		puts 'nooot'
   else
		update_hole_colors(@active_hole, @game_id)
   	@hit_r_final = Hit.find(:first, :conditions => conditions1) || Hit.create(conditions1)
    @hit_p_final = Hit.find(:first, :conditions => conditions2) || Hit.create(conditions2)
   end
   conditions3 = { :hit_planed_id => @hit_p_final.id,
                      :hit_real_id => @hit_r_final.id,
             	        :user_id => current_user.id,
                      :game_id => game_id}
   @pair_hit = PairHit.find(:first, :conditions => conditions3) || PairHit.create(conditions3)
   @hit_r_final.pair_id = @pair_hit.id
   @hit_p_final.pair_id = @pair_hit.id
   @hit_r_final.update_attributes(params[:pair_id])
   @hit_p_final.update_attributes(params[:pair_id])
   if @active_hit.to_i == 1
		create_hit_colors(@game_id, @active_hole)
	 	@hit_r_final.update_attributes(:place_from => 2)
		@hit_p_final.update_attributes(:place_from => 2)
		distance = @hole.get_proper_distance(@game_id)
		@hit_p_final.update_attributes(:distance_to_hole => distance)
	 else
		@hits = Hit.where(:game_id => @game_id, :hole_number => @active_hole, :real_hit => "pp")
		create_hit_colors(@game_id, @active_hole)
	 end
   	@pair_hit.update_attributes(params[:pair_hit])
   	@form_id = 'details'
		convert_from_m(@hit_p_final)
		convert_from_m(@hit_r_final)
		if @hit_r_final.land_place == 11
			check_hole_status(@game.id, @active_hole)
		end
		puts @hits
    render 'games/details'
	end
     
     
	def get_game_holes(game_id, active_hole)
	  @game_id = game_id
    @active_hole = active_hole
    @game = Game.find_by_id(game_id)
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

	def get_results_with_count(game_id, next_hole, hitcount, puts)    
  	get_game_holes(game_id, next_hole)
    @active_hole = next_hole
    @hitcount = hitcount
    @puts = puts
    if @hitcount == nil
    	@hitcount = 5
      @puts = 2
    end  
   	@form_id = 'results'
    if @active_hole.to_i < @start_hole.to_i
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
      end
      a = ((b + 1)..@hitcount)
      a.each do |i|
      	conditions = { :game_id => @game.id, 
                             :hole_number => @active_hole,
                             :hit_number => i, 
                             :real_hit => 'r',
                             :stick_id => 1 }
        @hit = Hit.find(:first, :conditions => conditions) || Hit.create(conditions)
      end
			@hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r') 
    else
      @hits = Hit.where(:game_id => @game.id,:hole_number => @active_hole,:real_hit => 'r')
    end
		@hits.each {|h| convert_from_m(h)}
    render 'games/results'
	end

	def convert_to_m(hit)
			hit_distance = hit.hit_distance 
			distance_to_hole = hit.distance_to_hole 
			measurement = current_user.measurement
      hit.hit_distance = Stick.convert_distance_to_meters(measurement, hit_distance) if hit_distance
      hit.distance_to_hole = Stick.convert_distance_to_meters(measurement, distance_to_hole) if distance_to_hole
			puts "TO METERS"
    	hit.save!

  end
	
	def convert_from_m(hit)
			hit_distance = hit.hit_distance 
			distance_to_hole = hit.distance_to_hole 
			measurement = current_user.measurement
      hit.hit_distance = Stick.convert_distance_from_meters(measurement, hit_distance) if hit_distance
      hit.distance_to_hole = Stick.convert_distance_from_meters(measurement, distance_to_hole) if distance_to_hole
			puts "FROM METERS"

  end

 end
