class Announcement < ActiveRecord::Base

	belongs_to :user
	belongs_to :golf_club

	has_attached_file :image, :default_url => '/images/anonymous_icon.png',
              :url => "/announcement/:attachment/:id_:style.:extension",
              :path => ":rails_root/public/announcement/:attachment/:id_:style.:extension"


	scope :for_newsfeed, lambda {|limit, offset, club_id_array| where('announcements.golf_club_id IN(?)', club_id_array).limit(limit).offset(offset).order('announcements.created_at desc')}

	scope :latest, lambda {|limit, club_id| where('announcements.golf_club_id IN(?)', [club_id, ADMIN_GOLF_CLUB_ID]).limit(limit).order('announcements.created_at desc')}

	scope :by_single_club, lambda {|club_id| where('announcements.golf_club_id = ?', club_id).order('announcements.created_at desc')}

	scope :my_feed, lambda {|limit, offset, club_id| where('announcements.golf_club_id = ?', club_id).offset(offset).limit(limit).order('announcements.created_at desc')}

	scope :by_admin, lambda {|limit, offset| where('announcements.golf_club_id = ?', ADMIN_GOLF_CLUB_ID).limit(limit).offset(offset).order('announcements.created_at desc')}

	def self.convert_to_header(full_text, header_length)
		header = truncate(full_text, header_length, "...")
	end
	
end
