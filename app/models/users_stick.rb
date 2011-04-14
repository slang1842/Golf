class UsersStick < ActiveRecord::Base
  belongs_to :user
  belongs_to :stick
  validates_presence_of :distance, :degrees, :shaft, :shaft_strength, :message => "fill all fields"
end
