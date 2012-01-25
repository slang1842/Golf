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

	def self.club_id_array_by_country(country_id)
		clubs = where(:country_id => country_id)
		return_arr = []
		clubs.each {|club| return_arr << club.id.to_i }
		return_arr << ADMIN_GOLF_CLUB_ID
		puts return_arr
		return return_arr
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
