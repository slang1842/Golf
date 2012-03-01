class AdminController < ApplicationController
  before_filter :require_super_admin, :except => :index
  skip_before_filter :require_no_super_admin
  skip_before_filter :require_user #, :only => :index
  before_filter :require_user, :only => :index
    
  def index   
    if current_user
      unless current_user.is_super_admin
        current_user_session.destroy
        redirect_to welcome_url
        flash[:notice] = "You have no access to this page"
      end
    end
  end

	def edit_help
		@help_text = ""
		@help_file = File.open("app/views/share/_help_text.html.erb", "r") do |f|
			while (line = f.gets)
				@help_text += line
			end
		end
	end

	def save_help
		puts params[:help_text]
		@help_file = File.open("app/views/share/_help_text.html.erb", "r+") do |f|
			@help_text = f.syswrite(params[:help_text])
		end
		redirect_to admin_path
	end

end
