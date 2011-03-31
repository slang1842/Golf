class User < ActiveRecord::Base
  belongs_to :golf_club
    
  acts_as_authentic do |c| 
    c.login_field = :email 
  end
  
  SEX_TO_DB = { "female" => "f", "male" => "m" }
  SEX_FROM_DB = { "f" => "female", "m" => "male" }
  
  #RIGHT_HANDED_TO_DB = { "Labrocis" => true, "Kreilis" => false }
  #RIGHT_HANDED_FROM_DB ={ true => "Labrocis", false => "Kreilis" }
  
  def get_administrate_golf_club
    return self.admin ? self.golf_club : false;
  end
  
  has_attached_file :image, 
              :url => "/user/:attachment/:id_:style.:extension",
              :path => ":rails_root/public/user/:attachment/:id_:style.:extension"

end
