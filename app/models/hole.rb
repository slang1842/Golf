class Hole < ActiveRecord::Base
  belongs_to :field
    
  has_attached_file :image, 
              :url => "/hole/:attachment/:id_:style.:extension",
              :path => ":rails_root/public/hole/:attachment/:id_:style.:extension"
	
	before_save :convert_distance

	def convert_distance
		self.distance = Stick.convert_distance_to_meters(self.field.golf_club.user.measurement, self.distance)
		self.very_short_distance = Stick.convert_distance_to_meters(self.field.golf_club.user.measurement, self.very_short_distance)
		self.short_distance = Stick.convert_distance_to_meters(self.field.golf_club.user.measurement, self.short_distance)
		self.normal_distance = Stick.convert_distance_to_meters(self.field.golf_club.user.measurement, self.normal_distance)
		self.long_distance = Stick.convert_distance_to_meters(self.field.golf_club.user.measurement, self.long_distance)
	end

  def self.get_proper_distance(hole_id, start_color)
    hole = self.find(hole_id)
    field = hole.field
    if start_color.to_i == field.very_short_distance.to_i
      distance = hole.very_short_distance
    elsif start_color.to_i == field.short_distance.to_i
      distance = hole.short_distance
    elsif start_color.to_i == field.normal_distance.to_i
      distance = hole.normal_distance
    elsif start_color.to_i == field.long_distance.to_i
      distance = hole.long_distance
    end
    return distance
  end
  #GAME_HOLE_FILTER = {
   # "3" => {:hole_number == (1..18)}
    #"2" => {:hole_number == (10..18)}
    #"1" => {:hole_number == (1..9)}
    #}

  #def self.scope_by_filter game_type
   # if GAME_HOLE_FILTER.has_key?(game_type)
   #   where(GAME_HOLE_FILTER[game_type][:hole_number] 
    #else
     # self.all
    #end
  #end
  
end
