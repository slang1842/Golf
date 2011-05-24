class GolfClub < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  has_many :fields
	validates :name, :region, :city, :web_page, :presence => true
  validates :name, :web_page, :uniqueness => true
  def to_s
    self.name
  end
  
  
end