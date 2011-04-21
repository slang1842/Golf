class PairHit < ActiveRecord::Base
  belongs_to :hit, :foreign_key => 'hit_planed'
  belongs_to :hit, :foreign_key => 'hit_real'
  
  belongs_to :user

end
