class Field < ActiveRecord::Base
  belongs_to :golf_club
  has_many :green_fees
  accepts_nested_attributes_for :green_fees, :allow_destroy => true
  has_many :holes
  accepts_nested_attributes_for :holes, :allow_destroy => true
  has_many :hit_places
  accepts_nested_attributes_for :hit_places, :allow_destroy => true
  
  validates_presence_of :golf_club
  
end
