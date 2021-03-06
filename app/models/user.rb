class User < ActiveRecord::Base
  belongs_to :golf_club
	belongs_to :country	
  has_many :users_sticks, :dependent => :destroy
  has_many :sticks, :through => :users_sticks
  has_many :balls
  has_many :hits
  has_many :pair_hits
  has_many :games
	has_many :hints
	has_many :statistics
	has_many :single_field_statistics
	has_many :all_stick_statistics
	has_many :failed_strokes
  accepts_nested_attributes_for :users_sticks, :allow_destroy => true
  accepts_nested_attributes_for :balls, :allow_destroy => true
  
  validates :first_name, :last_name, :nick, :presence => true #:birth, :presence => true
  validates :email, :uniqueness => true #, :message => '%{:email} has already been taken'

  
  validates :ball_manufacturer, :ball_type, :on => :bag, :presence => true
  validates :stick_type, :distance, :degrees, :shaft, :shaft_strength, :is_in_bag,{:on => :bag, :presence => true}
	
	scope :latest, where("users.image_file_name IS NOT NULL").limit(4).order("users.created_at desc") 
  
  acts_as_authentic do |c| 
    c.login_field = :email
  end
  
  SEX_TO_DB = { "female" => "f", "male" => "m" }
  SEX_FROM_DB = { "f" => "female", "m" => "male" }
  
  #RIGHT_HANDED_TO_DB = { "Labrocis" => true, "Kreilis" => false }
  #RIGHT_HANDED_FROM_DB ={ true => "Labrocis", false => "Kreilis" }
  
  def get_administrate_golf_club
    return self.admin ? self.golf_club : false
  end
  
  has_attached_file :image, :default_url => '/images/anonymous_icon.png',
              :url => "/user/:attachment/:id_:style.:extension",
              :path => ":rails_root/public/user/:attachment/:id_:style.:extension"

	def deliver_password_reset_instructions!  
		reset_perishable_token!  
		GolfMailer.deliver_password_reset_instructions(self)  
	end  
end
