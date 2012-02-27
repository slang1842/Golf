class GamesController < ApplicationController
 before_filter :require_user
 before_filter :require_game_owner, :except => [ :index,  :new, :create, :more_games, :switch_hit_places, :get_stats, :get_stats_remote]
 
    
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

 def delete
		Game.delete_with_stuff(params[:game_id])
		respond_to :js
 end
  
	def get_stats
		game_holes
	  @field = Field.find(:first, :conditions => {:id => @game.field_id})
	  render '/game_statistics/view/'
	end

	def get_stats_remote
		 game_holes
		 @field = Field.find(:first, :conditions => {:id => @game.field_id})
		 respond_to :js
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
		@path = '/game_details/fill_holes/' + params[:form_id] + '/' + @game.id.to_s 
     redirect_to @path
	end

	def fill_hole_information
		@game = Game.find(params[:game_id])
		fetch_hole_colors
		@direction = params[:direction]
	end
	
	def edit_hole_information_from_index
		@game = Game.find(params[:game_id])
		@direction = 'index'
		@active_hit = 1		
		fetch_hole_colors
		@active_hole = @statusholes.first.hole_number
		render 'games/edit_hole_information'
	end
	

	def update_holes
		@game = Game.find(params[:game_id])
		if @game.update_attributes(params[:game])
			Hit.render_hits_anew(@game.id) unless @game.hits.any?
			if params[:direction] == "details"
				Hit.check_for_differences(@game.id)
				@path = '/game_details/' + @game.id.to_s + '/1' + '/1' + '/new/0'
			elsif params[:direction] == 'index'
				Hit.check_for_differences(@game.id)
				@path = '/games'
			else
				Hit.check_for_plan_differences(@game.id)
				@path = '/game_plan/' + @game.id.to_s + '/1' + '/1' + '/new'			
			end
			redirect_to @path
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
 
	def plan
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
		#@fetched_sticks = fetch_proper_clubs(current_user.sticks, current_user.users_sticks, @hit.stick_id)    
    @form_id = 'plan'
		create_hole_colors_for_plan
		Hit.convert_from_m(@hit[0], current_user.measurement)
    if params[:hits] == 'new'
    	render '/games/hit_edit'
    else
    	render 'games/plan'
    end
  end
    
	def details
		fetch_hole_colors
		reset_stats
		@all_hits = @game.hits
    @active_hole = params[:active_hole]
    @active_hit = params[:active_hit]
    if @active_hit.to_i == 0
    	@active_hit = 1
    end
   
    if @active_hit.to_i != 1
    	fix_params(@active_hole, @active_hit, @game.id, @hole.distance)
    else
      @hit_r_final = Hit.fetch_real(@active_hole, @active_hit, @all_hits)
   	  @hit_p_final = Hit.fetch_planned(@active_hole, @active_hit, @all_hits) 
    end

		if @active_hit.to_i == 1
			update_hole_colors(@active_hole, @game.id)
			@hit_p_final.update_attributes(:distance_to_hole => @hole.get_proper_distance(@game.start_place_colors)) if @hit_p_final.distance_to_hole == nil
		end

		Hit.convert_from_m(@hit_r_final, current_user.measurement)
		Hit.convert_from_m(@hit_p_final, current_user.measurement)
		@pair_hit = PairHit.find_by_hit_planed_id(@hit_p_final.id)
    @form_id = 'details'
		create_hit_colors(@game.id, @active_hole)
		@fetched_sticks = fetch_proper_clubs(current_user.sticks, current_user.users_sticks, @hit_p_final.stick_id)
		@status_hole = StatusHole.where(:hole_number => @hit_p_final.hole_number, :game_id => @hit_p_final.game_id).first  
    if params[:hits] == 'new'
    	render '/games/hit_edit_details'
    end
	end
       

  def fix_params(active_hole, active_hit, game_id, hole_distance)
 		@hit_real_prev = Hit.fetch_real_prev(active_hole, active_hit, @all_hits)
		@hit_planned_prev = Hit.fetch_planned_prev(active_hole, active_hit, @all_hits)
		@hit_real = Hit.fetch_real(active_hole, active_hit, @all_hits)
		@hit_planned = Hit.fetch_planned(active_hole, active_hit, @all_hits)
		unless @hit_planned.real_hit.to_s == 'penalty'
			set_land_place
			set_distance_to_hole
			set_hole_and_putter
			if @hit_planned.distance_to_hole != nil && @hit_planned.stick_id == nil && @hit_planned.hit_distance == nil
				@hit_planned.hit_distance = @hit_planned.distance_to_hole
				find_proper_stick
			end
			@hit_planned.save
			@hit_real.save
		end
		@hit_r_final = @hit_real
		@hit_p_final = @hit_planned
	end
 

	def find_proper_stick
			sticks = current_user.sticks
			difference = 9999
			stickid = 0
			desired_distance = @hit_planned.hit_distance
			sticks.each do |stick|
				diff = (desired_distance - stick.distance).abs
				if difference > diff
					difference = diff
					stickid = stick.id
				end
			end		
		@hit_planned.update_attributes(:stick_id => stickid)
	end
	
	def set_hole_and_putter
		if @hit_planned.place_from == 1 || @hit_planned.place_from == 7
			if @hit_planned.stick_id == nil
				@hit_planned.land_place = 11
			end
		end
	end

	def set_land_place
		if @hit_planned.place_from == nil
			 @hit_planned.place_from = @hit_real_prev.land_place 					
		end
	end

	def set_distance_to_hole
		if @hit_real_prev.hit_distance != nil && @hit_planned_prev.distance_to_hole != nil
			@hit_planned.distance_to_hole = (@hit_planned_prev.distance_to_hole - @hit_real_prev.hit_distance).abs  
		else 
			@hit_planned.distance_to_hole = 0
	  end
	end

  def hit_update
		@next_hole = params[:next_hole].to_s
    require_game_owner
    if @game.update_attributes(params[:game])
    end
		#ugly fix
		i = 0
		while params[:game][:hits_attributes][:"#{i}"] != nil
			@hit1 = Hit.find_by_id(params[:game][:hits_attributes][:"#{i}"][:id])
			Hit.convert_to_m(@hit1, @hit1.user.measurement) if @hit1
			i += 1
		end
		#end of ugly fix	
	 if params[:form_id].to_s == "details" then update_hit_colors(@game.id, @hit1.hole_number, @hit1.hit_number) end
	 if params[:form_id].to_s == "details" then check_hole_status( @game.id, @hit1.hole_number) end
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
		 elsif params[:form_id].to_s == 'remove_hit'
				edit_hole_information(@game_id, 'plan', params[:active_hit], @next_hole)
		 elsif params[:next_hit].to_s == 'penalty'
				Hit.create_penalty(@game_id, params[:active_hit], @next_hole)
				create_hit_colors(@game_id, @next_hole.to_i)
				get_details(params[:form_id], @game_id, @next_hole, params[:active_hit].to_i)
		  elsif params[:next_hit].to_s == 'delete'
				edit_hole_information(@game_id, params[:form_id], params[:active_hit], @next_hole)
		 elsif params[:next_hit].to_s == 'remove_penalty'
				Hit.remove_penalty(@game_id, params[:active_hit], @next_hole)
				create_hit_colors(@game_id, @next_hole.to_i)
				get_details(params[:form_id], @game_id, @next_hole, params[:active_hit])
     elsif params[:form_id].to_s == 'details'
        get_details(params[:form_id], @game_id, @next_hole, @active_hit)
     end
  end
 
  def game_holes
		if params[:active_hole] != nil
    	@active_hole = params[:active_hole].to_i 
		else
			@active_hole = params[:next_hole].to_i
		end
    @game = Game.includes(:hits).includes(:pair_hits).includes(:status_holes).find(params[:game_id])
		@all_hits = @game.hits
    @holes = Hole.where(:field_id => @game.field_id)
		puts "called game_holes"
		puts @holes
    case @game.game_type
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
    @holes_filtered = @holes.select {|h| hole_num.include?(h.hole_number) }
    @form_type = params[:form_type]
	  @hole = @holes.detect {|h| h.hole_number == @active_hole}
  end
	
	def create_hole_colors_for_plan
		session[:hole_statuses] = {}
		@holes_filtered.each do |hole|
			hits = Hit.where(:game_id => @game.id, :hole_number => hole.hole_number, :real_hit => 'p').last
			if hits
				if hits.land_place == 11 then res = 2 else	res = 1	end
			else
				res = nil
			end
			session[:hole_statuses][:"#{hole.hole_number}"] = res		
		end		
	end

	def fetch_hole_colors
		session[:hole_statuses] = {}
		@statusholes = []
		@holes_filtered.each do |hole|
			statushole = StatusHole.find_or_create_by_game_id_and_hole_number({:game_id => @game.id, :hole_number => hole.hole_number})
			@statusholes << statushole
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
			@statushole = StatusHole.find_or_create_by_game_id_and_hole_number({:game_id => game_id, :hole_number => hole_number})
			@statushole.completeness = 2
			@statushole.save!
			session[:hole_statuses][:"#{hole_number}"] = 2
			check_for_game_completeness(game_id)
		end
	end	

	def create_hit_colors(game_id, hole_number)
		session[:hit_statuses] = {}
		session[:stick_names] = {}
		@hits = Hit.where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?)", game_id, hole_number, ["pp", "penalty"]).order("hits.hit_number asc")
			@hits.each do |planned|
			pair = PairHit.find_by_hit_planed_id(planned.id)
			real = Hit.find_by_id(pair.hit_real_id)
			check_and_update_color(real, planned)
		end				
	end


	def update_hit_colors(game_id, hole_number, hit_number)
		planned = Hit.where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?)", game_id, hole_number, ["pp", "penalty"]).last
		real = Hit.where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit IN(?)", game_id, hole_number, ["pp", "penalty_r"]).last
		check_and_update_color(real, planned)
	end


	def check_and_update_color(real, planned)
		if session.present?
			if check_hits(real, planned) == true || check_hits(real, planned) == "penalty"
				session[:hit_statuses][:"#{planned.hit_number}"] = 1
			else
				session[:hit_statuses][:"#{planned.hit_number}"] = nil
			end
			if planned.stick_id != nil
				stick = Stick.find(planned.stick_id)
				session[:stick_names][:"#{planned.hit_number}"] = stick.short_name
			else
				session[:stick_names][:"#{planned.hit_number}"] = nil
			end
			if planned.real_hit == "penalty"
				session[:stick_names][:"#{planned.hit_number}"] = "penalty"
			end
		end
	end


	def check_hits(real, planned)
			if planned.place_from != nil && planned.land_place != nil && planned.stance != nil && planned.trajectory != nil && planned.hit_distance != nil && real.land_place != nil && real.luck_factor != nil && real.hit_distance != nil && real.misdirection != nil && real.mistake != nil && planned.stick_id != nil
				return_ = true
			elsif planned.real_hit.to_s == "penalty"
				return_ = "penalty"
			else
				return_ = false
		end
		return return_
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
    render 'games/print_game_plan', :layout => 'print'
  end
    

	def switch_hit_places
		@places = Field.get_hit_place_colors(params[:id])
	end

private

  def get_plan(form_id, game_id, next_hole, active_hit)
  	@form_id = form_id
    @game_id = game_id
    @next_hole = next_hole
    @active_hit = active_hit
		create_hole_colors_for_plan
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
		@hit.each {|h| Hit.convert_from_m(h, current_user.measurement)}     
    @form_id = 'plan'
    render 'games/plan'
	end
    
	
     
	def get_details(form_id, game_id, next_hole, active_hit)
	  @form_id = form_id
    @game_id = game_id
    @next_hole = next_hole
    @active_hit = active_hit
		@all_hits = @game.hits
   if @active_hit.to_i != 1 
   	fix_params(@active_hole, @active_hit, @game_id, @hole.distance)
   else
   	@hit_r_final = Hit.fetch_real(@active_hole, @active_hit,  @all_hits)
    @hit_p_final = Hit.fetch_planned(@active_hole, @active_hit, @all_hits)
   end
   @pair_hit = PairHit.find_by_hit_planed_id(@hit_p_final.id)
   if @active_hit.to_i == 1
		create_hit_colors(@game_id, @active_hole)
		distance = @hole.get_proper_distance(@game_id)
		@hit_p_final.update_attributes(:distance_to_hole => distance) unless @hit_p_final.distance_to_hole != nil
	 else
		create_hit_colors(@game_id, @active_hole)
	 end
   	@form_id = 'details'
		Hit.convert_from_m(@hit_p_final, current_user.measurement)
		Hit.convert_from_m(@hit_r_final, current_user.measurement)
		if @hit_r_final.land_place == 11
			check_hole_status(@game.id, @active_hole)
		end
		@fetched_sticks = fetch_proper_clubs(current_user.sticks, current_user.users_sticks, @hit_p_final.stick_id)
		@status_hole = StatusHole.where(:hole_number => @hit_p_final.hole_number, :game_id => @hit_r_final.game_id).first
		
		if @hit_r_final.real_hit.to_s == "rp"
    	render 'games/details'
		else
			render 'games/details_disabled'
		end
	end
     
	
	def check_for_game_completeness(game_id)
		status_holes = StatusHole.where(:game_id => game_id, :completeness => [0, 1])
			unless status_holes.any?
				game = Game.find(game_id)
				 game.update_attributes(:complete => 1)
			end
	end

	def reset_stats
		stats = Statistic.find_by_user_id(current_user.id)
		stats.update_attributes(:calculated => false) if stats != nil
	end
 
	def fetch_proper_clubs(sticks, usersticks, id_to_be_added)
		stick_id_arr = []
		usersticks.where(:is_in_bag => true).each {|stick| stick_id_arr << stick.stick_id}
		stick_arr = sticks.where(:id => stick_id_arr)
		stick_arr << sticks.where(:id => id_to_be_added).first if id_to_be_added != nil
		stick_arr.uniq!
		return stick_arr
	end
	
	def edit_hole_information(game_id, direction, active_hit, active_hole)
		@game = Game.find(game_id)
		@direction = direction
		@active_hit = active_hit
		@active_hole = active_hole
		fetch_hole_colors
		render 'games/edit_hole_information'
	end

end
