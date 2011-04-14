class GolfClub < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  has_many :fields
	validates_presence_of :name, :region, :city, :web_page
  
  def to_s
    self.name
  end
  
  
end