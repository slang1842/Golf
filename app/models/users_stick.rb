class UsersStick < ActiveRecord::Base
  belongs_to :user
  belongs_to :stick
  belongs_to :hits
  validates_presence_of :distance, :degrees, :shaft, :shaft_strength, :message => "fill all fields"
end
