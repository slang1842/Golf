class Ball < ActiveRecord::Base
  belongs_to :user
  #validates_presence_of :ball_manufacturer, :ball_type, :message => "fill all fields"
end
