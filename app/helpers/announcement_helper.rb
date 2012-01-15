module AnnouncementHelper

	def chars_for_heading(fulltext, length)
		return_text = truncate(fulltext, :length => 250)
		return return_text
	end

	def text_with_links(fulltext)
		status_text = []
		status_text = fulltext.split
		status1 = ' '
		status_text.each do |word|
			if word.to_s.match(/http:|https/)
				link = '<a href="' + word + '" target="_blank">' + word.truncate(20) + '</a>'
			elsif word.to_s.match(/www./)
				link = '<a href="http://' + word + '" target="_blank">' + word.truncate(20) + '</a>'	
			else
				link = word
			end
			status1 = status1 + link + ' '
		end
		raw status1
	end

end
