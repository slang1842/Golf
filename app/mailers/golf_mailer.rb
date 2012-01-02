class GolfMailer < ActionMailer::Base
  default :from => "zapte7@gmail.com"
  
  def send_hint(recipient, subject, message, sent_at = Time.now)
      @subject = subject
      @recipients = recipient
      @from = 'no-reply@yourdomain.com'
      @sent_on = sent_at
      @body["title"] = 'Golf'
      @body["email"] = 'sender@yourdomain.com'
      @body["message"] = message
      @headers = {}
  end

	def password_reset_instructions(user)  
		@subject = "Password Reset Instructions"   
		@recipients = user.email  
		@sent_on = Time.now  
		@body['title'] = 'Golf'
		@link = edit_password_reset_url(user.perishable_token)
		mail(:to => @recipients, :subject => @subject, :host => "localhost:3000")  
	end  

end
