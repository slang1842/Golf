class Hit < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :field
  belongs_to :hole
  
  has_one    :pair_hit
  #belongs_to :PairHit, :class => 'PairHit', :foreign_key => 'hit_planed'
  #belongs_to :PairHit, :class => 'PairHit', :foreign_key => 'hit_real'
  
  
  #scope :get_params, lambda { |place| where('place_from') = place }
   scope :get_place_from, lambda { |place| where('place_from = ?', place) }
end

