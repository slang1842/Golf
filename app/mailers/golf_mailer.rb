class GolfMailer < ActionMailer::Base
  default :from => "from@example.com"
  
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
end
