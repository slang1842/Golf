class Hole < ActiveRecord::Base
  belongs_to :field
    
  has_attached_file :image, 
              :url => "/hole/:attachment/:id_:style.:extension",
              :path => ":rails_root/public/hole/:attachment/:id_:style.:extension"

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
