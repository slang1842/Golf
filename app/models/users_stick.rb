class UsersStick < ActiveRecord::Base
  belongs_to :user
  has_many :sticks
end
