class SticksController < ApplicationController
  respond_to :json
  
  def show
    @sticks = Stick.find(params[:id])
		@sticks.distance = Stick.convert_distance_from_meters(current_user.measurement, @sticks.distance)
		@sticks.distance = @sticks.distance.ceil
		puts @sticks.distance
    respond_with @sticks
  end
end
