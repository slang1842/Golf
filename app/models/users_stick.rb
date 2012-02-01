class UsersStick < ActiveRecord::Base
  belongs_to :user
  belongs_to :stick
  belongs_to :hits
  has_many   :pair_hits
	
  validates :distance, :shaft, :shaft_strength, :presence => true
	before_save :convert_to_m

	def convert_to_m
		self.distance = Stick.convert_distance_to_meters(self.user.measurement, self.distance.to_f)
	end

end
