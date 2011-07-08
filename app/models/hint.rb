class Hint < ActiveRecord::Base
  belongs_to :user

 # scoped :recent :order=>'updated_at DESC'
end
