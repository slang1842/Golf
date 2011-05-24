class Hit < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :field
  belongs_to :hole
  
  #belongs_to :PairHit
  #belongs_to :hit_planed, :class => 'PairHit', :foreign_key => 'hit_planed_id'
  #belongs_to :hit_real, :class => 'PairHit', :foreign_key => 'hit_real_id'
  belongs_to :stick
  has_many :PairHit
  has_many :hit_planed, :class_name => 'PairHit', :foreign_key => 'hit_planed_id'
  has_many :hit_real, :class_name => 'PairHit', :foreign_key => 'hit_real_id'
  
  #scope :get_place_from, lambda { |place| where('place_from = ?', place) }
  
 
end