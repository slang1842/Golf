class UserStatsController < ApplicationController
   before_filter :require_user


def show
  @trainee = current_user
end

def sendmail
    email = @params["email"]
    recipient = email["recipient"]
    subject = email["subject"]
    message = email["message"]
    Emailer.deliver_send_hint(recipient, subject, message)
    return if request.xhr?
    render :text => 'Message sent successfully'
  end
  
end
