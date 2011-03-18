class User < ActiveRecord::Base
  acts_as_authentic do |c| 
    c.login_field = :email 
  end
  
  SEX_TO_DB = { "female" => "f", "male" => "m" }
  SEX_FROM_DB = { "f" => "female", "m" => "male" }
  
  RIGHT_HANDED_TO_DB = { "Righthander" => true, "Lefthander" => false }
  RIGHT_HANDED_FROM_DB{ true => "Righthander", false => "Lefthander" }
  
  MEASUREMENT_TO_DB = { "Meters" => "Meters", "Foots" => "Foots" }
  MEASUREMENT_FROM_DB{ "Meters" => "Meters", false => "Foots" }
end
