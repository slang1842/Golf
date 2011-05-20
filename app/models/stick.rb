class Stick < ActiveRecord::Base
  has_many :users_sticks
  has_many :sticks
  has_many :users, :through => :users_sticks
  has_many :hits
  
  validates_presence_of :stick_type, :distance, :degrees, :shaft, :shaft_strength, :short_name
end
