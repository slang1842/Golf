class UsersStick < ActiveRecord::Base
  belongs_to :user
  belongs_to :stick
  belongs_to :hits
  has_many   :pair_hits
  validates :distance, :degrees, :shaft, :shaft_strength, :presence => true
end
