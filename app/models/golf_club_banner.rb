class GolfClubBanner < ActiveRecord::Base
  belongs_to :trip
  has_attached_file :banner
end
