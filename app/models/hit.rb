class Hit < ActiveRecord::Base
  belongs_to_one :game
  belongs_to_one :user
end
