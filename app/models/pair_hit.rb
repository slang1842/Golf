class PairHit < ActiveRecord::Base
  belongs_to :hit
  belongs_to :user
end
