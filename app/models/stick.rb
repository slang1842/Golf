class Stick < ActiveRecord::Base
  has_many :users_sticks
  has_many :sticks
  has_many :users, :through => :users_sticks
  has_many :hits
  
  validates :stick_type, :distance, :degrees, :shaft, :shaft_strength, :short_name, :presence => true
end
