class GolfClub < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  has_many :fields
	validates :name, :region, :city, :web_page, :presence => true
  validates :name, :web_page, :uniqueness => true
  def to_s
    self.name
  end
  
  has_many :golf_club_banners#, :dependent => :destroy
  accepts_nested_attributes_for :golf_club_banners, :reject_if => lambda { |t| t['golf_club_banners'].nil? }

end