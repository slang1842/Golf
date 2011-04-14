class Game < ActiveRecord::Base
  belongs_to :user
  has_one :field
  has_many :hits
  
end
