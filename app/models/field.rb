class Field < ActiveRecord::Base
  belongs_to :golf_club
  has_many :green_fees, :dependent => :destroy
  accepts_nested_attributes_for :green_fees, :allow_destroy => true
  has_many :holes, :dependent => :destroy
  accepts_nested_attributes_for :holes, :allow_destroy => true
  has_many :hit_places, :dependent => :destroy
  accepts_nested_attributes_for :hit_places, :allow_destroy => true
  validates_presence_of :golf_club
 	
	def name_with_club
    "#{golf_club.name} / #{name}"
  end

	def self.get_hit_place_colors field_id
		field = self.find_by_id(field_id)
		a = field.very_short_distance unless field.very_short_distance == nil
		b = field.short_distance unless field.short_distance == nil
		c = field.long_distance unless field.long_distance == nil
		d = field.normal_distance unless field.normal_distance == nil
		arr =[a, b, c, d]
		arr = arr.uniq
		hash_final = []
		arr.each do |h|
			START_PLACE_ARRAY.each do |i|
				if h.to_i == i[:id] then hash_final << i end
			end
		end
		return hash_final
	end
end
