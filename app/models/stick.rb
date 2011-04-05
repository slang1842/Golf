class Stick < ActiveRecord::Base
  has_many :users_sticks
  has_many :users, :through => :users_sticks
end
