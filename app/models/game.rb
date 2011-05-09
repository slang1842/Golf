class Game < ActiveRecord::Base
  has_many :hits, :dependent => :destroy
  accepts_nested_attributes_for :hits
  belongs_to :user
   
end
