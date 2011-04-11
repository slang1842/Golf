class BallsController < ApplicationController
  respond_to :json
  

  def destroy
    @ball = Ball.find(params[:id])
    @ball_id = @ball.id
    @ball.destroy
  end
  
  def show
    @balls = Balls.find(params[:id])
    respond_with @balls
  end
  
  
end
