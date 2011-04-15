class Hit < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  belongs_to :field
  belongs_to :hole
end
