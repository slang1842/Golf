class Field < ActiveRecord::Base
  belongs_to :golf_club
  has_many :green_fees, :dependent => :destroy
  accepts_nested_attributes_for :green_fees, :allow_destroy => true
  has_many :holes, :dependent => :destroy
  accepts_nested_attributes_for :holes, :allow_destroy => true
  has_many :hit_places, :dependent => :destroy
  accepts_nested_attributes_for :hit_places, :allow_destroy => true
  
  validates_presence_of :golf_club
  
end
