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
 
	scope :non_putts, lambda{ |game_id, hole_number| where("hits.game_id = ? AND hits.hole_number = ? AND hits.real_hit = ? AND hits.place_from NOT IN(?)", game_id, hole_number, "pp", [1])}
	scope :putts, lambda{ |game_id, hole_number| where(:game_id => game_id, :hole_number => hole_number, :real_hit => "pp", :place_from => 1)}
end
