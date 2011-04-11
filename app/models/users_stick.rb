class UsersStick < ActiveRecord::Base
  belongs_to :user
  belongs_to :stick
end
