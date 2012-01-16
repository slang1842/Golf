class GolfClub < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  has_many :fields
	validates :name, :region, :city, :web_page, :presence => true
  validates :name, :web_page, :uniqueness => true
  belongs_to :golf_club_pay_banner
  
  def to_s
    self.name
  end
  
  has_attached_file :image_f,
    :url => "/images/golf_club/f_banner/:attachment/:id_:style.:extension",
    :path => ":rails_root/public/images/golf_club/f_banner/:attachment/:id_:style.:extension"
  
  has_attached_file :image_p,
    :url => "/images/golf_club/p_banner/:attachment/:id_:style.:extension",
    :path => ":rails_root/public/images/golf_club/p_banner/:attachment/:id_:style.:extension"
 
  has_attached_file :image_v,
    :url => "/images/golf_club/v_banner/:attachment/:id_:style.:extension",
    :path => ":rails_root/public/images/golf_club/v_banner/:attachment/:id_:style.:extension"

  has_attached_file :image_t,
    :url => "/images/golf_club/t_banner/:attachment/:id_:style.:extension",
    :path => ":rails_root/public/images/golf_club/t_banner/:attachment/:id_:style.:extension"

  
end
