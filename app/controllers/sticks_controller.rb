class SticksController < ApplicationController
  respond_to :json
  
  def show
    @sticks = Stick.find(params[:id])
    respond_with @sticks
  end
end
