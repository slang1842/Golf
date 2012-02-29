module StatisticsHelper

	def swap_bar_color(percentage)
		if percentage.to_i < 60
			return "bad"
		elsif percentage.to_i > 80
			return "good"
		else
    	return "normal"
		end

	end

	def fetch_coach(user_id)
		if user_id && user_id != nil
			user = User.find(user_id)
			raw user.first_name + " " + user.last_name
		end	
	end

	def render_percentages(failed_strokes, stick_id)
		if stick_id != nil
		raw '<div class="single_item" style="margin-top:4px">	Penalties : ' + failed_strokes.penalty_strokes.to_s + '
		</div>
<div class="single_item">
			Top ball: ' + failed_strokes.top_strokes.to_s + ' <br/> 
			Under ball: ' + failed_strokes.under_strokes.to_s + ' <br/> 
			Too close : ' + failed_strokes.short_strokes.to_s + ' 
		</div>
		<div class="single_item">
			Too far : ' + failed_strokes.long_strokes.to_s + ' <br/>
			Str left : ' + failed_strokes.left_strokes.to_s + ' <br/> 
			Str right : ' + failed_strokes.right_strokes.to_s + '
		</div>
		<div class="single_item">
			Spin left : ' + failed_strokes.more_left_strokes.to_s + '  <br/> 
			Spin right : ' + failed_strokes.more_right_strokes.to_s + '<br/>
			Straight : ' + failed_strokes.ok_strokes.to_s + ' <br/> 
		</div>'
		else
			raw '<div class="single_item" style="margin-top:4px">	Penalties : ' + failed_strokes.penalty_strokes.to_s + ' %
		</div>
<div class="single_item">
			Top ball: ' + failed_strokes.top_strokes.to_s + ' %<br/> 
			Under ball: ' + failed_strokes.under_strokes.to_s + ' %<br/> 
			Too close : ' + failed_strokes.short_strokes.to_s + ' %
		</div>
		<div class="single_item">
			Too far : ' + failed_strokes.long_strokes.to_s + ' %<br/>
			Str left : ' + failed_strokes.left_strokes.to_s + ' %<br/> 
			Str right : ' + failed_strokes.right_strokes.to_s + ' %
		</div>
		<div class="single_item">
			Spin left : ' + failed_strokes.more_left_strokes.to_s + ' % <br/> 
			Spin right : ' + failed_strokes.more_right_strokes.to_s + ' %<br/>
			Straight : ' + failed_strokes.ok_strokes.to_s + ' %<br/> 
		</div>'
		end
	end

end
