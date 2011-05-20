class GameStatisticsBySticks < ActiveRecord::Base
  belongs_to :games
  belongs_to :fields
  belongs_to :sticks
end
