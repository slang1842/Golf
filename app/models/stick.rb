class Stick < ActiveRecord::Base
  has_many :users_sticks
  has_many :sticks
  has_many :users, :through => :users_sticks
  has_many :hits
  
  validates :stick_type, :distance, :shaft, :shaft_strength, :short_name, :presence => true

	def self.convert_distance_to_meters (measurement_type, distance)
		puts "TO METERS"
		case measurement_type
			when "yd"
				@distance = distance * 0.9144
			when "ft"
				@distance = distance * 0.3048
			when "m"
				@distance = distance
		end
		return @distance
	end

	def self.convert_distance_from_meters(measurement_type, distance)
		case measurement_type
			when "yd"
				@distance = distance / 0.9144
			when "ft"
				@distance = distance / 0.3048
			when "m"
				@distance = distance
		end
		return @distance		
	puts "FROM METERS"
	end	 
end
