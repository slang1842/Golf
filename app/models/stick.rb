class Stick < ActiveRecord::Base
  has_many :users_sticks
  has_many :users, :through => :users_sticks
  belongs_to :hits
  validates_presence_of :stick_type, :distance, :degrees, :shaft, :shaft_strength
end
