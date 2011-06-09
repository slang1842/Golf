class HintsController < ApplicationController


  def new
    @hint = Hint.new
  end

  def edit
    @hint = Hint.find(params[:id])
  end

  def create
    @hint = Hint.new(params[:hint])
  end

  def update
    Hint.update_attributes(params[:id])
    redirect_back
  end

  def destroy
    @hint = Hint.find(params[:id])
    @hint.destroy
  end
end
