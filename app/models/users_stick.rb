class UsersStick < ActiveRecord::Base
  belongs_to :user
  belongs_to :stick
  belongs_to :hits
  has_many   :pair_hits
	cattr_accessor :skip_callbacks
  validates :distance, :shaft, :shaft_strength, :presence => true
	before_save :convert_to_m, :unless => :skip_callbacks

	def convert_to_m
		if self.stick_id == nil
			self.destroy
		else
			self.distance = Stick.convert_distance_to_meters(self.user.measurement, self.distance.to_f)
		end
	end

	def self.destroy(stick_id)
		stick = UsersStick.find(stick_id)
		stick.destroy
	end	

end
