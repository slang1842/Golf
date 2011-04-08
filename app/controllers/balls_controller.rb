class BallsController < ApplicationController


  def destroy
    @ball = Ball.find(params[:id])
    @ball_id = @ball.id
    @ball.destroy
    
    respond_to do |format|
      format.js
      format.xml  { head :ok }
    end
  end
  
  
  
end
