class PairHit < ActiveRecord::Base
  #belongs_to :hit, :foreign_key => 'hit_planed'
  #belongs_to :hit, :foreign_key => 'hit_real'
  belongs_to :user

  
  #has_many :Hit
  #has_many :hit_planed, :class => 'Hit', :foreign_key => 'hit_planed_id'
  #has_many :hit_real, :class => 'Hit', :foreign_key => 'hit_real_id'
  
  belongs_to :Hit
  belongs_to :hit_planed, :class_name => "Hit", :foreign_key => 'hit_planed_id'
  belongs_to :hit_real, :class_name => 'Hit', :foreign_key => 'hit_real_id'
end
