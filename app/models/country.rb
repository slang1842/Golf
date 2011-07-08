class Country < ActiveRecord::Base
belongs_to :golf_club

  def to_s
    self.name
  end
  
end
