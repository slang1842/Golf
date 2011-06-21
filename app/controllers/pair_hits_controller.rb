class PairHitsController < ApplicationController
  def update
    @pair_hit = PairHit.find(params[:id])

    @pair_hit.update_attributes(params[:pair_hit])
  end
end