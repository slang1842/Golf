class Hole < ActiveRecord::Base
  belongs_to :field
  
  has_attached_file :image, 
              :url => "/hole/:attachment/:id_:style.:extension",
              :path => ":rails_root/public/hole/:attachment/:id_:style.:extension"
end
