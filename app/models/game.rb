class Game < ActiveRecord::Base
  #has_many :hits, :dependent => :destroy
  has_many :pair_hits
  has_many :hits
  accepts_nested_attributes_for :hits
  accepts_nested_attributes_for :pair_hits
  belongs_to :user
  belongs_to :field
  has_many :holes, :through => :field
  
end
