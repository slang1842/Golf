class GameStatisticsByHoles < ActiveRecord::Base
  belongs_to :games
  belongs_to :fields
end
